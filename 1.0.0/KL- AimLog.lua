local s = require "./♛KIM-Beta♛//KIM/KL- hud print chat"
local misses = ui.new_checkbox("Rage", "Other", "[ KIM ] Log misses")
local hits = ui.new_checkbox("Rage", "Other", "[ KIM ] Log hits")
local function on_aim_hit(e)
	if ui.get(hits) then

        local hitgroup_names = { "body", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear" }
        local group = hitgroup_names[e.hitgroup + 1] or "?"

        local target_name = entity.get_player_name(e.target)
       
		local entityHealth = entity.get_prop(e.target, "m_iHealth")
		s.print_chat(" \x03[\x03KIM-Beta\x03.] " .. "\x03  target: \x01" .. string.lower(target_name) .. "\x03 hitbox: \x01" .. group .. "\x03 hp: \x01" .. entityHealth .. "\x03 hc: \x01" .. string.format("%d", e.hit_chance) .. "%")
    end
end

local function on_aim_miss(e)
	if ui.get(misses) and e ~= nil then

    local hitgroup_names = { "body", "head", "chest", "stomach", "left arm", "right arm", "left leg", "right leg", "neck", "?", "gear" }
    local group = hitgroup_names[e.hitgroup + 1] or "?"
    local target_name = entity.get_player_name(e.target)
    local reason
	local entityHealth = entity.get_prop(e.target, "m_iHealth")
	if (entityHealth == nil) or (entityHealth <= 0) then
		client.log("The player was killed prior to your shot being able to land")
	return
	end
    if e.reason == "?" then
    	reason = "resolver"
    else
    	reason = e.reason
    end
		s.print_chat(" \x02[\x02KIM-Beta\x02] " .. "\x02  missed \x01" .. string.lower(target_name) .. "\x02's " .. " \x09" .. group .. "\x02 due to \x01" .. reason)
    end
end


client.set_event_callback('aim_hit', on_aim_hit)
client.set_event_callback('aim_miss', on_aim_miss)