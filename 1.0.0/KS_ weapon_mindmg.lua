local set_dmg_list = function()
    local damage_list = { }

    damage_list[0] = 'Auto'

    for i = 1, 26 do
        -- HP + {1-26}
        -- HP = 0 -> Auto
    
        damage_list[100 + i] = 'HP+' .. i
    end

    return damage_list
end

local ui_get, ui_set, is_alive = ui.get, ui.set, entity.is_alive
local ref_mindmg = ui.reference("Rage", "Aimbot", "Minimum damage")

local active = ui.new_checkbox("Rage", "Aimbot", "[ KIM ] Override Key")
local override_key = ui.new_hotkey("Rage", "Aimbot", "[ KIM ] Override Key", true)

local override_dmg = ui.new_slider('RAGE', 'Aimbot', 'Override damage', 0, 126, 50, true, '', 1, set_dmg_list())


local ui_callback = function()
    local is_active = ui_get(active)

    ui.set_visible(override_dmg, is_active)

end

local paint_handler = function()
    local dval, oval = 
        ui_get(override_dmg)

end

client.set_event_callback('paint', paint_handler)
ui.set_callback(active, ui_callback)
ui_callback()

client.set_event_callback("paint", function(c) 
    if ui.get(override_key) then
        renderer.indicator(50,255,255, 255, "" .. ui.get(override_dmg))
	elseif using_visible_dmg == true then
		renderer.indicator(125,190, 255, 255)
    end
end)