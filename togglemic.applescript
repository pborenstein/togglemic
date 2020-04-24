-- technique from http://www.alfredforum.com/topic/2486-mute-mic/
-- code from http://superuser.com/a/397770/40768

-- If script is recompiled, e.g. because it gets modified, then the property
-- will be reset to the default value of 100
property previousInputVolume : 100

set inputVolume to input volume of (get volume settings)
if inputVolume = 0 then
    set inputVolume to previousInputVolume
else
    copy inputVolume to previousInputVolume
    set inputVolume to 0
end if
set volume input volume inputVolume
return inputVolume
