local ui_get = ui.get
local console_cmd = client.exec
local ui_new_checkbox = ui.new_checkbox

local fudu = ui_new_checkbox("LUA", "A", "fudu")
local function on_player_chat(e)
    if not ui_get(fudu) then return end
	if e.text == "!rs" or e.text == "rs" then return end
	if e.teamonly == false then
		console_cmd("say "..e.text)
	end
end

client.set_event_callback("player_chat", on_player_chat)