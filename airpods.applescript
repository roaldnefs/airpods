#!/usr/bin/env osascript

use framework "IOBluetooth"
use scripting additions


-- Check if the specified bluetooth device is connected. Returns true if the
-- specified device is connection, false otherwise.
on isDeviceConnected(substring)
	repeat with device in (current application's IOBluetoothDevice's pairedDevices() as list)
		if device's isConnected and (device's nameOrAddress as string) contains substring then return true
	end repeat
	
	return false
end isDeviceConnected


-- Set the sound input device the the specified device. If the device isn't
-- listed it will default to the first listed input device.
on setSoundInputDevice(deviceName)
	if deviceName is missing value then set deviceName to "MacBook Pro Microphone"
	
	-- Open the sound settings
	tell application "System Preferences" to activate
	tell application "System Preferences"
		reveal anchor "input" of pane id "com.apple.preference.sound"
	end tell
	
	-- Select the preferred microphone
	tell application "System Events" to tell process "System Preferences"
		tell table 1 of scroll area 1 of tab group 1 of window 1
			if deviceName is not equal to missing value and ((first row whose value of text field 1 is deviceName) exists) then
				select (first row whose value of text field 1 is deviceName)
			else
				select row 1
			end if
			tell application "System Preferences" to quit
		end tell
	end tell
end setSoundInputDevice


on run {deviceName}
	if isDeviceConnected("AirPods") then
		return setSoundInputDevice(deviceName)
	end if	
end run
