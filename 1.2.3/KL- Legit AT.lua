local autowall = ui.reference("RAGE", "Aimbot", "Automatic Penetration")

local autowalltoggle = ui.new_checkbox("RAGE", "Other", "Enabled AutoWall")
local autowalltoggle_key = ui.new_hotkey("RAGE", "Other", "Enabled AUTOWALL",true)

client.set_event_callback("setup_command", function(cmd)
    if ui.get(autowalltoggle) then
		ui.set(autowall, ui.get(autowalltoggle_key))
	end
end)

client.set_event_callback("paint", function()
	if not ui.get(autowalltoggle) then
			return
	else 
		if ui.get(autowall)	then
			renderer.indicator(40, 255, 242, 255,  "AutoWall: on")
		else
			renderer.indicator(255, 0, 0, 255, "AutoWall: off")
		end
	end

end)