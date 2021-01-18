#!/usr/bin/env osascript

tell application "System Preferences" to activate
tell application "System Preferences"
	reveal anchor "input" of pane id "com.apple.preference.sound"
end tell

tell application "System Events" to tell process "System Preferences"
	tell table 1 of scroll area 1 of tab group 1 of window 1
		if ((first row whose value of text field 2 is "Built-in") exists) then
			select (first row whose value of text field 2 is "Built-in")
			delay 2
		end if
		tell application "System Preferences" to quit
	end tell
end tell
