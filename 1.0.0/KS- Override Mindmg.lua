local change = false
local stored_target = nil

local set_dmg_list = function()
    local damage_list = { }

    damage_list[0] = "Auto"

    for i = 1, 26 do
        -- HP + {1-26}
        -- HP = 0 -> Auto
    
        damage_list[100 + i] = "HP+" .. i
    end

    return damage_list
end

local ref_min_dmg = ui.reference("Rage", "Aimbot", "Minimum damage")
local override_key = ui.new_hotkey("Rage", "Other", "[ KIM ] Override Key")
local override_dmg = ui.new_slider("Rage", "Aimbot", "Override minimum damage", 0, 126, 0, true, "", 1, set_dmg_list())
local stored_dmg = 0


local function changed(c)
    local h_key = ui.get(override_key)
    local dmg_slider_ref = ui.get(override_dmg)
    
    if h_key and change == false then
        stored_dmg = ui.get(ref_min_dmg)
        ui.set(ref_min_dmg, dmg_slider_ref)
        change = true
    elseif not h_key and change == true then
        ui.set(ref_min_dmg, stored_dmg)
        change = false
    end	
end

local v = false
local using_visible_dmg = false

client.set_event_callback("paint", changed)


client.set_event_callback("paint", function(c) 
    if ui.get(override_key) then
        renderer.indicator(255,255,255, 255, "" .. ui.get(override_dmg))
	elseif using_visible_dmg == true then
		renderer.indicator(125,190, 255, 255)
    end
end)

