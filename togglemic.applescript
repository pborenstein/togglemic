-- technique from http://www.alfredforum.com/topic/2486-mute-mic/
-- code from http://superuser.com/a/397770/40768
-- Reading and writing the state file written with help from
--   http://www.nobleswan.com/applescript/AS_snippets.html
set actualInputVolume to input volume of (get volume settings)
set stateFile to (system attribute "HOME") & "/.togglemic.state"

if actualInputVolume = 0 then
	try
		open for access stateFile
		set savedVolume to (read stateFile)
		close access stateFile
	on error
		set savedVolume to "100"
	end try

	set actualInputVolume to savedVolume as real
else
	open for access stateFile with write permission
	set eof of stateFile to 0
	write actualInputVolume as string to stateFile
	close access stateFile

	set actualInputVolume to 0
end if

set volume input volume actualInputVolume

return actualInputVolume
