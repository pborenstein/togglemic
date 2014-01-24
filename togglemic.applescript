-- technique from http://www.alfredforum.com/topic/2486-mute-mic/
-- code from http://superuser.com/a/397770/40768
--     54 is where my mic is set. Yours may be different

set inputVolume to input volume of (get volume settings)
if inputVolume = 0 then
    set inputVolume to 54
else
    set inputVolume to 0
end if
set volume input volume inputVolume
return inputVolume
