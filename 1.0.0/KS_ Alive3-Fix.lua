local ui_get = ui.get
local client_set_event_callback = client.set_event_callback
local client_console_cmd = client.exec
local new_button = ui.new_checkbox("MISC", "Settings", "Disable collision")
local slider = ui.new_slider("MISC", "Settings", "Thirdperson delta", 0, 150, 150, 1)

ui.set_callback(slider, function()
slider_val = ui.get(slider)
client.exec("cam_idealdist ", slider_val)
end)

ui.set_callback(new_button, function()
if ui_get(new_button) then
  client_console_cmd("cam_collision 0")
else
  client_console_cmd("cam_collision 1")
end
end)