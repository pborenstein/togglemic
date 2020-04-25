-- technique from http://www.alfredforum.com/topic/2486-mute-mic/
-- code from http://superuser.com/a/397770/40768

set defaultInputVolume to 75

-- If script is recompiled, e.g. because it gets modified, then the property
-- will be reset to the default value (defaultInputVolume).
property previousInputVolume : {}

set mic to getDefaultMic()
set inputVolume to input volume of (get volume settings)
if inputVolume = 0 then
    set inputVolume to getVariableValue(previousInputVolume, mic, defaultInputVolume)
else
    setVariableValue(previousInputVolume, mic, inputVolume)
    set inputVolume to 0
end if
set volume input volume inputVolume
return inputVolume

-- Return "<device>/<source>"
on getDefaultMic()
    set items_xpath to "dict/key[text()=\"_items\"]/following-sibling::array[1]/"
    return do shell script "system_profiler -xml SPAudioDataType | " & ¬
        "xmllint --xpath '/plist/array/" & items_xpath & items_xpath & "dict[./key[text()=\"coreaudio_default_audio_input_device\"]/following-sibling::string[1]=\"spaudio_yes\"]' - | " & ¬
        "xmllint --xpath 'concat(/dict/key[text()=\"_name\"]/following-sibling::string[1]/text(), \"/\", /dict/key[text()=\"coreaudio_input_source\"]/following-sibling::string[1]/text())' -"
end getDefaultMic

on setVariableValue(dict, identifier, amount)
    repeat with i from 1 to (length of dict)
        if item i of dict is identifier then
            set item (i + 1) of dict to amount
            return
        end if
    end repeat
    copy identifier to the end of dict
    copy amount to the end of dict
end setVariableValue

on getVariableValue(dict, identifier, default)
    repeat with i from 1 to (length of dict)
        if item i of dict is identifier then
            return item (i + 1) of dict
        end if
    end repeat
    return default
end getVariableValue
