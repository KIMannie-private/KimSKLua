local r_reserve = ui.reference("MISC", "Settings", "Double tap reserve")
local r_ticks = ui.reference("MISC", "Settings", "sv_maxusrcmdprocessticks")

local c_slider = ui.new_slider("Rage", "Other", "[ KIM ] Double Tap Speed", -1, 4, 4, true, nil, 1, {
    [-1.0] = "Warning"
})
local dt, dt_key = ui.reference("RAGE", "other", "Double tap")
local fakeducking = ui.reference("RAGE", "Other", "Duck peek assist")


local doubletap_enhancement = function ()
    local lp = entity.get_local_player();
    local wep = entity.get_player_weapon(lp);
    if lp == nil or wep == nil then
        return end ;
    local index = bit.band(65535, entity.get_prop(wep, "m_iItemDefinitionIndex"))

    if not ui.get(fakeducking) and (index == 38 or index == 11) and (ui.get(dt) and ui.get(dt_key)) then
        ui.set(r_reserve, ui.get(c_slider) < 1 and 1 or ui.get(c_slider))
        ui.set(r_ticks, ui.get(c_slider) >= 1 and 16 or 17)
        client.set_cvar("cl_clock_correction", ui.get(r_reserve) == -1 and "0" or "1")
    else
        ui.set(r_reserve, 4)
        ui.set(r_ticks, 16)
        client.set_cvar("cl_clock_correction", "1")
    end
end

local movementEventHandler = function (e)
    doubletap_enhancement(e)
end

client.set_event_callback("run_command", movementEventHandler)


