---[ API ]---
local _M = {}
local authed = false
local luaName = " AT"

local function body()
local client_latency, client_log, client_draw_rectangle, client_draw_circle_outline, client_userid_to_entindex, client_draw_indicator, client_draw_gradient, client_set_event_callback, client_screen_size, client_eye_position = client.latency, client.log, client.draw_rectangle, client.draw_circle_outline, client.userid_to_entindex, client.draw_indicator, client.draw_gradient, client.set_event_callback, client.screen_size, client.eye_position 
local client_camera_angles, client_color_log, client_create_interface, client_delay_call, client_draw_hitboxes, client_eye_position, client_get_cvar, client_latency, client_log, client_screen_size, client_set_cvar, client_set_event_callback, client_userid_to_entindex, client_visible, entity_get_classname, entity_get_local_player, entity_get_player_name, entity_get_player_weapon, entity_get_players, entity_get_prop, entity_hitbox_position, globals_absoluteframetime, globals_realtime, globals_tickinterval, math_abs, math_atan2, math_floor, math_pow, math_sqrt, renderer_circle, renderer_circle_outline, renderer_indicator, renderer_text, renderer_world_to_screen, require, string_format, string_match, table_concat, table_insert, table_remove, ui_get, ui_new_button, ui_new_checkbox, ui_new_color_picker, ui_new_combobox, ui_new_hotkey, ui_new_multiselect, ui_new_slider, ui_reference, ui_set, ui_set_callback, ui_set_visible, error = client.camera_angles, client.color_log, client.create_interface, client.delay_call, client.draw_hitboxes, client.eye_position, client.get_cvar, client.latency, client.log, client.screen_size, client.set_cvar, client.set_event_callback, client.userid_to_entindex, client.visible, entity.get_classname, entity.get_local_player, entity.get_player_name, entity.get_player_weapon, entity.get_players, entity.get_prop, entity.hitbox_position, globals.absoluteframetime, globals.realtime, globals.tickinterval, math.abs, math.atan2, math.floor, math.pow, math.sqrt, renderer.circle, renderer.circle_outline, renderer.indicator, renderer.text, renderer.world_to_screen, require, string.format, string.match, table.concat, table.insert, table.remove, ui.get, ui.new_button, ui.new_checkbox, ui.new_color_picker, ui.new_combobox, ui.new_hotkey, ui.new_multiselect, ui.new_slider, ui.reference, ui.set, ui.set_callback, ui.set_visible, error
-------------

---[ Vars ]---
client_color_log(180, 238, 0, '---[ Info ]---')
client_color_log(255, 255, 255, 'KIM private Legit-aa')
client_color_log(255, 255, 255, 'Update:2020/6/6')
client_color_log(180, 238, 0, '--------------')

local ffi = require('ffi')

local vars = {
	name_player = nil,
	dynamicfov_new = 0,
	bool_in_fov = false,
	closest_enemy = nil,
	visible = false,
	fire = false,
	penetration = false,
	penetration_shotme = false,
	cached_target,
	oldcfg = nil,
	legitaa_check = false,
	legitaa_value1 = false,
	legitaa_value2 = false,
	legitaa_show_slider = false,
	legitaa_fps_slider = false,
	legitaa_ping_slider = false,
	legitaa_speed_slider = false,
	legitaa_loss_slider = false,
	legitaa_choke_slider = false,
	legitaa_stop1 = false,
	legitaa_stop2 = false,
	legitaa_stop3 = false,
	legitaa_stop4 = false,
	legitaa_stop5 = false,
}

local weapon_classes = {
	['CWeaponG3SG1'] = 'Snipers',
	['CWeaponSCAR20'] = 'Snipers',
	['CWeaponAWP'] = 'Snipers',
	['CWeaponSSG08'] = 'Snipers',
	['CDEagle'] = 'Deagle',
	['CWeaponFiveSeven'] = 'Pistols',
	['CWeaponHKP2000'] = 'Pistols',
	['CWeaponP250'] = 'Pistols',
	['CWeaponGlock'] = 'Pistols',
	['CWeaponElite'] = 'Pistols',
	['CWeaponTec9'] = 'Pistols',
	['CAK47'] = 'Rifles',
	['CWeaponAug'] = 'Rifles',
	['CWeaponFamas'] = 'Rifles',
	['CWeaponGalilAR'] = 'Rifles',
	['CWeaponM4A1'] = 'Rifles',
	['CWeaponSG556'] = 'Rifles',
	['CWeaponMP7'] = 'SMG',
	['CWeaponMP9'] = 'SMG',
	['CWeaponBizon'] = 'SMG',
	['CWeaponP90'] = 'SMG',
	['CWeaponUMP45'] = 'SMG',
	['CWeaponM249'] = 'Machine gun',
	['CWeaponNegev'] = 'Machine gun',
	['CWeaponMag7'] = 'Shotgun',
	['CWeaponNOVA'] = 'Shotgun',
	['CWeaponSawedoff'] = 'Shotgun',
	['CWeaponXM1014'] = 'Shotgun',
}

local function table_contains(tbl, val)
	for i=1, #tbl do
	  if tbl[i] == val then
		return true
	  end
	end
	return false
end

local function can_see(ent)
    for i = 0, 18 do
        if client_visible(entity_hitbox_position(ent, i)) then
            return true
        end
    end
    return false
end

local function FpsTable()
	local Fps_Table = {}
	Fps_Table[59] = 'Tickrate'
	for i = 1, 241 do
		Fps_Table[59+i] = 59+i .. 'fps'
	end
	return Fps_Table
end

local function setName(delay, name)
    client_delay_call(delay, function() 
        client_set_cvar('name', name)
    end)
end
--------------

---[ References ]---
local rage = {
	ragebot = { ui_reference('RAGE', 'Aimbot', 'Enabled') },
	fire = ui_reference('RAGE', 'Aimbot', 'Automatic fire'),
	penetration = ui_reference('RAGE', 'Aimbot', 'Automatic penetration'),
	fov = ui_reference('RAGE', 'Aimbot', 'Maximum FOV'),
	miss = ui_reference('RAGE', 'Aimbot', 'Log misses due to spread'),
	force_safe_point = ui_reference('RAGE', 'Aimbot', 'Force safe point'),
	force_body_aim = ui_reference('RAGE', 'Other', 'Force body aim'),
}

local aa = {
	antiaim = { ui_reference('AA', 'Anti-aimbot angles', 'Enabled') },
	pitch = { ui_reference('AA', 'Anti-aimbot angles', 'Pitch') },
	yaw_base = { ui_reference('AA', 'Anti-aimbot angles', 'Yaw base') },
	yaw = { ui_reference('AA', 'Anti-aimbot angles', 'Yaw') },
	yaw_jitter = { ui_reference('AA', 'Anti-aimbot angles', 'Yaw jitter') },
	body_yaw = { ui_reference('AA', 'Anti-aimbot angles', 'Body yaw') },
	fs_body_yaw = ui_reference('AA', 'Anti-aimbot angles', 'Freestanding body yaw'),
	body_yaw_target = { ui_reference('AA', 'Anti-aimbot angles', 'Lower body yaw target') },
	edge_yaw = ui_reference('AA', 'Anti-aimbot angles', 'Edge yaw'),
	fake_yaw_limit = { ui_reference('AA', 'Anti-aimbot angles', 'Fake yaw limit') },
	fs = { ui_reference('AA', 'Anti-aimbot angles', 'Freestanding') },
}

local fl = {
	fakelag = { ui_reference('AA', 'Fake lag', 'Enabled') },
	limit = ui_reference('AA', 'Fake lag', 'Limit'),
}

local misc = {
	cfg = { ui_reference('CONFIG', 'Presets', 'Presets') },
	damage = ui_reference('MISC', 'Miscellaneous', 'Log damage dealt'),
	namesteal = ui_reference('MISC', 'Miscellaneous', 'Steal player name'),
}

local useless = {
	pitch = { ui_reference('AA', 'Anti-aimbot angles', 'Pitch') },
	yaw_base = { ui_reference('AA', 'Anti-aimbot angles', 'Yaw base') },
	yaw = { ui_reference('AA', 'Anti-aimbot angles', 'Yaw') },
	yaw_jitter = { ui_reference('AA', 'Anti-aimbot angles', 'Yaw jitter') },
	edge_yaw = ui_reference('AA', 'Anti-aimbot angles', 'Edge yaw'),
	fake_yaw_limit = { ui_reference('AA', 'Anti-aimbot angles', 'Fake yaw limit') },
	fs = { ui_reference('AA', 'Anti-aimbot angles', 'Freestanding') },
	onshot_aa = { ui_reference('AA', 'Other', 'On shot anti-aim') },
	fake_peek = { ui_reference('AA', 'Other', 'Fake peek') },
	double_tap = { ui_reference('RAGE', 'Other', 'Double tap') },
}
--------------------

---[ Menu ]---
local semirage = {
	lite = ui_new_checkbox('RAGE', 'Other', '[ KIM ] Legit Rage'),
	improvements = ui_new_checkbox('RAGE', 'Other', 'Improvements'),
	improvements_mode = { ui_new_multiselect('RAGE', 'Other', 'Aimbot improvements', 'Snipers', 'Deagle', 'Pistols', 'Rifles', 'SMG', 'Machine gun', 'Shotgun') },
	improvements_hotkey = ui_new_hotkey('RAGE', 'Other', '\nAimbot improvements', true, 0x01),
	fire = ui_new_checkbox('RAGE', 'Other', 'Automatic fire'), 
	fire_hotkey = ui_new_hotkey('RAGE', 'Other', 'Automatic fire', true),
	penetration = ui_new_checkbox('RAGE', 'Other', 'Automatic penetration'), 
	penetration_hotkey = ui_new_hotkey('RAGE', 'Other', 'Automatic penetration', true),
	penetration_mode = { ui_new_multiselect('RAGE', 'Other', '\nPenetration mode', 'On hotkey', 'Visible', 'Shot me') },
	penetration_delay_turnson = ui_new_slider('RAGE', 'Other', 'Turns on if shot me', 1, 120, 1, true, 's'),
	penetration_delay_stayson = ui_new_slider('RAGE', 'Other', 'Stays on if shot me', 1, 180, 50, true, 's'),
	dynamicfov = ui_new_checkbox('RAGE', 'Other', 'Dynamic FOV'),
	dynamicfov_mode = { ui_new_combobox('RAGE', 'Other', '\nDynamic FOV', 'Off', 'Static', 'Auto') },
	dynamicfov_restrict = ui_new_checkbox('RAGE', 'Other', 'Restrict updates'),
	dynamicfov_min = ui_new_slider('RAGE', 'Other', 'Minimal FOV', 1, 180, 3, true, '°', 1),
	dynamicfov_max = ui_new_slider('RAGE', 'Other', 'Maximum FOV', 1, 180, 6, true, '°', 1),
	dynamicfov_auto_factor = ui_new_slider('RAGE', 'Other', 'Automatic Factor', 0, 250, 30, true, 'x', 0.01),
	dynamicfov_indicators1 = { ui_new_combobox('RAGE', 'Other', '\nIndicators1', 'Off', 'Circle', 'Outline') },
	dynamicfov_colors1 = ui_new_color_picker('RAGE', 'Other', '\nIndicators1', 123, 194, 21, 50),
	dynamicfov_indicators2 = { ui_new_combobox('RAGE', 'Other', '\nIndicators2', 'Off', 'Change circle color', 'Draw hitboxes') },
	dynamicfov_colors2 = ui_new_color_picker('RAGE', 'Other', '\nIndicators2', 194, 20, 20, 50),
	indicators = ui_new_checkbox('RAGE', 'Other', 'Indicators'),
	indicators_mode = { ui_new_multiselect('RAGE', 'Other', '\nIndicators', 'Automatic fire', 'Automatic penetration', 'Force body aim', 'Force safe point') },
	indicators_color = ui_new_color_picker('RAGE', 'Other', '\nIndicators', 123, 194, 21, 255),
	advanced_logs = ui_new_checkbox('RAGE', 'Other', 'Advanced logs'),
	logs_mode = { ui_new_multiselect('RAGE', 'Other', '\nAdvanced logs', 'Fire', 'Hit', 'Miss')},
	hide_useless_features = ui_new_checkbox('RAGE', 'Other', 'Hide useless features'),
}

local legitaa = {
	enabled = ui_new_checkbox('AA', 'Anti-aimbot angles', 'Legit AA'),
	legitaa_key = ui_new_hotkey('AA', 'Anti-aimbot angles', 'Legit AA', true),
	indicators = { ui_new_multiselect('AA', 'Anti-aimbot angles', 'Indicators', 'Arrow', 'Text') },
	indicators_color = ui_new_color_picker('AA', 'Anti-aimbot angles', 'Indicators', 76, 148, 255, 255),
	both_arrows = ui_new_checkbox('AA', 'Anti-aimbot angles', 'Show both arrows'),
	arrows_color = ui_new_color_picker('AA', 'Anti-aimbot angles', '\nShow both arrows', 255, 255, 255, 255),
	aa_mode = { ui_new_combobox('AA', 'Anti-aimbot angles', 'Mode', 'Safe', 'Maximum') },
	auto_off = { ui_new_multiselect('AA', 'Anti-aimbot angles', 'Auto-Off', 'Show sliders', 'FPS', 'Ping', 'Speed', 'Loss', 'Choke') },
	fps_slider = ui_new_slider('AA', 'Anti-aimbot angles', 'FPS threshold', 59, 300, 59, true, '', 1, FpsTable()),
	ping_slider = ui_new_slider('AA', 'Anti-aimbot angles', 'Ping threshold', 0, 150, 75, true, 'ms'),
	speed_slider = ui_new_slider('AA', 'Anti-aimbot angles', 'Speed threshold', 0, 250, 135, true, 'u'),
	loss_slider = ui_new_slider('AA', 'Anti-aimbot angles', 'Loss threshold', 0, 10, 1, true, '%'),
	choke_slider = ui_new_slider('AA', 'Anti-aimbot angles', 'Choke threshold', 0, 10, 1, true, '%'),
}

local spam = ui_new_button('MISC', 'Miscellaneous', 'Get Good Get GameSense', function()
	local player = entity_get_local_player()
	local player_name = entity_get_player_name(player)
	vars.name_player = player_name
	local name = vars.name_player
	ui_set(misc.namesteal, true)
	client_set_cvar('name', name)
	setName(0.1, 'Get') 
	setName(0.2, 'Get Good')
	setName(0.3, 'Get Good Get')
	setName(0.4, 'Get Good Get GameSense')
	setName(0.5, name)
end)
--------------

---[ Function #1 ]---
local function visibility()

	local lite = ui_get(semirage.lite)
	local improvements = ui_get(semirage.improvements)
	local fire = ui_get(semirage.fire)
	local penetration = ui_get(semirage.penetration)
	local penetration_onhotkey = table_contains(ui_get(semirage.penetration_mode[1]), 'On hotkey')
	local penetration_shotme = table_contains(ui_get(semirage.penetration_mode[1]), 'Shot me')
	local dynamicfov = ui_get(semirage.dynamicfov)
	local dynamic_off = (ui_get(semirage.dynamicfov_mode[1]) == 'Off')
	local dynamic_static = (ui_get(semirage.dynamicfov_mode[1]) == 'Static')
	local dynamic_auto = (ui_get(semirage.dynamicfov_mode[1]) == 'Auto')
	local dynamic_indicators1 = (ui_get(semirage.dynamicfov_indicators1[1]) == 'Off')
	local dynamic_indicators2 = (ui_get(semirage.dynamicfov_indicators2[1]) == 'Off')
	local indicators = ui_get(semirage.indicators)
	local logs = ui_get(semirage.advanced_logs)
	local logs_hit = table_contains(ui_get(semirage.logs_mode[1]), 'Hit')
	local logs_miss = table_contains(ui_get(semirage.logs_mode[1]), 'Miss')
	local aa = ui_get(legitaa.enabled)
	local aa_indicators = table_contains(ui_get(legitaa.indicators[1]), 'Arrow') or table_contains(ui_get(legitaa.indicators[1]), 'Text')
	local aa_indicators_arrow = table_contains(ui_get(legitaa.indicators[1]), 'Arrow')
	local aa_sliders = table_contains(ui_get(legitaa.auto_off[1]), 'Show sliders')
	local aa_fps = table_contains(ui_get(legitaa.auto_off[1]), 'FPS')
	local aa_ping = table_contains(ui_get(legitaa.auto_off[1]), 'Ping')
	local aa_speed = table_contains(ui_get(legitaa.auto_off[1]), 'Speed')
	local aa_loss = table_contains(ui_get(legitaa.auto_off[1]), 'Loss')
	local aa_choke = table_contains(ui_get(legitaa.auto_off[1]), 'Choke')
	local hide_useless = ui_get(semirage.hide_useless_features)

	if lite == true then
		ui_set_visible(semirage.fire, true)
		ui_set_visible(semirage.penetration, true)
		ui_set_visible(semirage.dynamicfov, true)
		ui_set_visible(semirage.indicators, true)
		ui_set_visible(semirage.hide_useless_features, true)
		ui_set_visible(semirage.advanced_logs, true)
		ui_set_visible(semirage.improvements, true)
		ui_set_visible(legitaa.enabled, true)
		ui_set_visible(spam, true)
	else
		ui_set(semirage.fire, false)
		ui_set_visible(semirage.fire, false)
		ui_set(semirage.penetration, false)
		ui_set_visible(semirage.penetration, false)
		ui_set(semirage.dynamicfov, false)
		ui_set_visible(semirage.dynamicfov, false)
		ui_set(semirage.indicators, false)
		ui_set_visible(semirage.indicators, false)
		ui_set(semirage.hide_useless_features, false)
		ui_set_visible(semirage.hide_useless_features, false)
		ui_set(semirage.advanced_logs, false)
		ui_set_visible(semirage.advanced_logs, false)
		ui_set(semirage.improvements, false)
		ui_set_visible(semirage.improvements, false)
		ui_set(legitaa.enabled, false)
		ui_set_visible(legitaa.enabled, false)
		ui_set_visible(spam, false)
	end

	if improvements then
		ui_set_visible(semirage.improvements_mode[1], true)
		ui_set_visible(semirage.improvements_hotkey, true)
	else
		ui_set_visible(semirage.improvements_mode[1], false)
		ui_set_visible(semirage.improvements_hotkey, false)
	end
	
	if fire then
		ui_set_visible(semirage.fire_hotkey, true)
	else
		ui_set_visible(semirage.fire_hotkey, false)
	end
	
	if penetration then
		ui_set_visible(semirage.penetration_mode[1], true)
	else
		ui_set(semirage.penetration_mode[1], '-')
		ui_set_visible(semirage.penetration_mode[1], false)
	end

	if dynamicfov then
		ui_set_visible(semirage.dynamicfov_mode[1], true)
	else
		ui_set(semirage.dynamicfov_mode[1], 'OFf')
		ui_set_visible(semirage.dynamicfov_mode[1], false)
		ui_set(semirage.dynamicfov_indicators1[1], 'Off')
		ui_set(semirage.dynamicfov_indicators2[1], 'Off')
	end

	if penetration_onhotkey then
		ui_set_visible(semirage.penetration_hotkey, true)
	else
		ui_set_visible(semirage.penetration_hotkey, false)
	end

	if penetration_shotme then
		ui_set_visible(semirage.penetration_delay_stayson, true)
		ui_set_visible(semirage.penetration_delay_turnson, true)
	else
		ui_set_visible(semirage.penetration_delay_stayson, false)
		ui_set_visible(semirage.penetration_delay_turnson, false)
	end

	if dynamic_off then
		ui_set_visible(semirage.dynamicfov_min, false)
		ui_set_visible(semirage.dynamicfov_max, false)
		ui_set_visible(semirage.dynamicfov_auto_factor, false)
		ui_set_visible(semirage.dynamicfov_restrict, false)
		ui_set_visible(semirage.dynamicfov_indicators1[1], false)
		ui_set_visible(semirage.dynamicfov_indicators2[1], false)
	end

	if dynamic_static then
		ui_set_visible(semirage.dynamicfov_min, true)
		ui_set_visible(semirage.dynamicfov_max, true)
		ui_set_visible(semirage.dynamicfov_auto_factor, false)
		ui_set_visible(semirage.dynamicfov_restrict, true)
		ui_set_visible(semirage.dynamicfov_indicators1[1], true)
		ui_set_visible(semirage.dynamicfov_indicators2[1], true)
	end

	if dynamic_auto then
		ui_set_visible(semirage.dynamicfov_min, true)
		ui_set_visible(semirage.dynamicfov_max, true)
		ui_set_visible(semirage.dynamicfov_auto_factor, true)
		ui_set_visible(semirage.dynamicfov_restrict, true)
		ui_set_visible(semirage.dynamicfov_indicators1[1], true)
		ui_set_visible(semirage.dynamicfov_indicators2[1], true)
	end

	if dynamic_indicators1 then
		ui_set_visible(semirage.dynamicfov_colors1, false)
	else
		ui_set_visible(semirage.dynamicfov_colors1, true)
	end

	if dynamic_indicators2 then
		ui_set_visible(semirage.dynamicfov_colors2, false)
	else
		ui_set_visible(semirage.dynamicfov_colors2, true)
	end

	if indicators then
		ui_set_visible(semirage.indicators_mode[1], true)
		ui_set_visible(semirage.indicators_color, true)
	else
		ui_set_visible(semirage.indicators_mode[1], false)
		ui_set_visible(semirage.indicators_color, false)
	end

	if logs then
		ui_set_visible(semirage.logs_mode[1], true)
	else
		ui_set(semirage.logs_mode[1], '-')
		ui_set_visible(semirage.logs_mode[1], false)
	end

	if logs_hit then
		ui_set(misc.damage, false)
		ui_set_visible(misc.damage, false)
	else
		ui_set_visible(misc.damage, true)
	end

	if logs_miss then
		ui_set(rage.miss, false)
		ui_set_visible(rage.miss, false)
	else
		ui_set_visible(rage.miss, true)
	end

	if aa then
		ui_set_visible(legitaa.legitaa_key, true)
		ui_set(legitaa.legitaa_key, 'Toggle')
		ui_set_visible(legitaa.indicators[1], true)
		ui_set_visible(legitaa.aa_mode[1], true)
		ui_set_visible(legitaa.auto_off[1], true)
	else
		ui_set_visible(legitaa.legitaa_key, false)
		ui_set_visible(legitaa.indicators[1], false)
		ui_set_visible(legitaa.aa_mode[1], false)
		ui_set_visible(legitaa.auto_off[1], false)
	end

	if aa_indicators then
		ui_set_visible(legitaa.indicators_color, true)
	else
		ui_set_visible(legitaa.indicators_color, false)
	end

	if aa_indicators_arrow then
		ui_set_visible(legitaa.both_arrows, true)
		ui_set_visible(legitaa.arrows_color, true)
	else
		ui_set_visible(legitaa.both_arrows, false)
		ui_set_visible(legitaa.arrows_color, false)
	end

	if aa_sliders then
		ui_set_visible(legitaa.fps_slider, aa_fps)
		ui_set_visible(legitaa.ping_slider, aa_ping)
		ui_set_visible(legitaa.speed_slider, aa_speed)
		ui_set_visible(legitaa.loss_slider, aa_loss)
		ui_set_visible(legitaa.choke_slider, aa_choke)
	else
		ui_set_visible(legitaa.fps_slider, false)
		ui_set_visible(legitaa.ping_slider, false)
		ui_set_visible(legitaa.speed_slider, false)
		ui_set_visible(legitaa.loss_slider, false)
		ui_set_visible(legitaa.choke_slider, false)
	end

	if hide_useless then
		ui_set_visible(useless.pitch[1], false)
		ui_set_visible(useless.yaw_base[1], false)
		ui_set_visible(useless.yaw[1], false)
		ui_set_visible(useless.yaw[2], false)
		ui_set_visible(useless.yaw_jitter[1], false)
		ui_set_visible(useless.yaw_jitter[2], false)
		ui_set_visible(useless.edge_yaw, false)
		ui_set_visible(useless.fs[1], false)
		ui_set_visible(useless.fs[2], false)
		ui_set_visible(useless.onshot_aa[1], false)
		ui_set_visible(useless.onshot_aa[2], false)
		ui_set_visible(useless.fake_peek[1], false)
		ui_set_visible(useless.fake_peek[2], false)
		ui_set_visible(useless.double_tap[1], false)
		ui_set_visible(useless.double_tap[2], false)
		ui_set_visible(useless.fake_yaw_limit[1], false)
	else
		ui_set_visible(useless.pitch[1], true)
		ui_set_visible(useless.yaw_base[1], true)
		ui_set_visible(useless.yaw[1], true)
		ui_set_visible(useless.yaw[2], true)
		ui_set_visible(useless.edge_yaw, true)
		ui_set_visible(useless.fs[1], true)
		ui_set_visible(useless.fs[2], true)
		ui_set_visible(useless.onshot_aa[1], true)
		ui_set_visible(useless.onshot_aa[2], true)
		ui_set_visible(useless.fake_peek[1], true)
		ui_set_visible(useless.fake_peek[2], true)
		ui_set_visible(useless.double_tap[1], true)
		ui_set_visible(useless.double_tap[2], true)
		ui_set_visible(useless.fake_yaw_limit[1], true)
	end
end
client_set_event_callback('paint', visibility)
---------------------

---[ Function #2 ]---
local function on_paint(ctx)

	local r, g, b, a = ui_get(semirage.indicators_color)
	local current_weapon = weapon_classes[entity_get_classname(entity_get_player_weapon(entity_get_local_player()))]

	local enabled, fov, penetration, fire = ui_get(rage.ragebot[1]), ui_get(rage.fov), ui_get(rage.penetration), ui_get(rage.fire)
	local improvements_hotkey = ui_get(semirage.improvements_hotkey)
	local IsFire = ui_get(semirage.fire_hotkey)
	local IsPenetration = ui_get(semirage.penetration_hotkey) 
	local IsForceSafePoint = ui_get(rage.force_safe_point)
	local IsForceBodyAim = ui_get(rage.force_body_aim)
	local indicator_fire = table_contains(ui_get(semirage.indicators_mode[1]), 'Automatic fire')
	local indicator_penetration = table_contains(ui_get(semirage.indicators_mode[1]), 'Automatic penetration')
	local indicator_baim = table_contains(ui_get(semirage.indicators_mode[1]), 'Force body aim')
	local indicator_safe = table_contains(ui_get(semirage.indicators_mode[1]), 'Force safe point')

	if enabled then
		renderer_indicator(r, g, b, a, 'FOV: ', fov, '°')
	end

	if penetration and indicator_penetration then
		renderer_indicator(r, g, b, a, 'AW')
	end

	if fire and indicator_fire then
		renderer_indicator(r, g, b, a, 'TM')
	end

	if IsFire or improvements_hotkey and table_contains(ui_get(semirage.improvements_mode[1]), current_weapon) then
		vars.fire = true
	else
		vars.fire = false
	end

	if IsPenetration then
		vars.penetration = true
	else
		vars.penetration = false
	end

	if IsForceBodyAim and indicator_baim then
		renderer_indicator(r, g, b, a, 'BM')
	end

	if IsForceSafePoint and indicator_safe then
		renderer_indicator(r, g, b, a, 'SP')
	end

	if vars.fire then
		ui_set(rage.ragebot[2], 'Always on')
		ui_set(rage.fire, true)
	else
		ui_set(rage.ragebot[2], 'On hotkey')
		ui_set(rage.fire, false)
	end

end
client_set_event_callback('paint', on_paint)
---------------------

---[ Function #3 ]---
local function DynamicFOV()
	local mode = ui_get(semirage.dynamicfov_mode[1])
	if mode ~= 'Off' then
		local old_fov = ui_get(rage.fov)
		vars.dynamicfov_new_fov = old_fov
	    local enemy_players = entity_get_players(true)

	    local min_fov = ui_get(semirage.dynamicfov_min)
	    local max_fov = ui_get(semirage.dynamicfov_max)

	    if min_fov > max_fov then
	    	local store_min_fov = min_fov
	    	min_fov = max_fov
	    	max_fov = store_min_fov
		end
		
		if #enemy_players ~= 0 then
	        local own_x, own_y, own_z = client_eye_position()
	        local own_pitch, own_yaw = client_camera_angles()
	        vars.closest_enemy = nil
	        local closest_distance = 999999999
	        
	        for i = 1, #enemy_players do
	            local enemy = enemy_players[i]
	            local enemy_x, enemy_y, enemy_z = entity_hitbox_position(enemy, 0)
	            
	            local x = enemy_x - own_x
	            local y = enemy_y - own_y
	            local z = enemy_z - own_z 

	            local yaw = ((math_atan2(y, x) * 180 / math.pi))
	            local pitch = -(math_atan2(z, math_sqrt(math_pow(x, 2) + math_pow(y, 2))) * 180 / math.pi)

	            local yaw_dif = math_abs(own_yaw % 360 - yaw % 360) % 360
	            local pitch_dif = math_abs(own_pitch - pitch ) % 360
	            
	            if yaw_dif > 180 then
	                yaw_dif = 360 - yaw_dif
	            end

	            local real_dif = math_sqrt(math_pow(yaw_dif, 2) + math_pow(pitch_dif, 2))

	            if closest_distance > real_dif then
	                closest_distance = real_dif
	                vars.closest_enemy = enemy
	            end
	        end
	        
	        if vars.closest_enemy ~= nil then
	        	local closest_enemy_x, closest_enemy_y, closest_enemy_z = entity_hitbox_position(vars.closest_enemy, 0)
		        local real_distance = math_sqrt(math_pow(own_x - closest_enemy_x, 2) + math_pow(own_y - closest_enemy_y, 2) + math_pow(own_z - closest_enemy_z, 2))

	        	if mode == 'Static' then
	                vars.dynamicfov_new = max_fov - ((max_fov - min_fov) * (real_distance - 250) / 1000)
		        elseif mode == 'Auto'  then
		        	vars.dynamicfov_new = (3800 / real_distance) * (ui_get(semirage.dynamicfov_auto_factor) * 0.01)
		        end

		        if (vars.dynamicfov_new > max_fov) then
		        	vars.dynamicfov_new = max_fov
		        elseif vars.dynamicfov_new < min_fov then
		        	vars.dynamicfov_new = min_fov
		        end
	        end

	        vars.dynamicfov_new = math_floor(vars.dynamicfov_new + 0.5)

	        if (vars.dynamicfov_new > closest_distance)  then
	        	vars.bool_in_fov = true
	        else
	        	vars.bool_in_fov = false
	        end
	    else 
	        vars.dynamicfov_new = min_fov
	        vars.bool_in_fov = false
		end
		
		if vars.dynamicfov_new ~= old_fov then
	    	ui_set(rage.fov, vars.dynamicfov_new)
		end
		
	end
end

local function DynamicFOV_drawing()
	local mode = ui_get(semirage.dynamicfov_mode[1])

	if mode ~= 'Off' then
		local indicators_mode = ui_get(semirage.dynamicfov_indicators1[1])
		local indicators_in_fov = ui_get(semirage.dynamicfov_indicators2[1])

		local r, g, b, a = ui_get(semirage.dynamicfov_colors1)
		local r2, g2, b2, a2 = ui_get(semirage.dynamicfov_colors2)

		if indicators_mode ~= 'Off' then

			if (indicators_in_fov == 'Change circle color') and (vars.bool_in_fov) then
				r, g, b, a = r2, g2, b2, a2
			end

			if string_match(indicators_mode, 'Circle') or string_match(indicators_mode, 'Outline') then
				local w, h = client_screen_size()
				local w_mid, h_mid = w / 2, h / 2
				local model_fov = client_get_cvar('viewmodel_fov')
				local fov_radius = vars.dynamicfov_new / model_fov * w / 2

				if string_match(indicators_mode, 'Circle') then
					renderer_circle(w_mid, h_mid, r, g, b, a, fov_radius, 0, 1)
				elseif string_match(indicators_mode, 'Outline') then
					if vars.bool_in_fov then
						renderer_circle_outline(w_mid, h_mid, r, g, b, a, fov_radius, 0, 1, math_floor(1 + vars.dynamicfov_new / 10) * 2)
					else
						renderer_circle_outline(w_mid, h_mid, r, g, b, a, fov_radius, 0, 1, math_floor(1 + vars.dynamicfov_new / 10))
					end
				end
			end
		end

		if (indicators_in_fov == 'Draw hitboxes') then
			if vars.bool_in_fov and (vars.closest_enemy ~= nil) then
				client_draw_hitboxes(vars.closest_enemy, 0.01, 19, r2, g2, b2)
			end
		end
	end

end

local function on_run_command()
	if ui_get(semirage.dynamicfov_restrict) then
		DynamicFOV()
	end
end
client_set_event_callback('run_command', on_run_command)

local function dynamicfov_paint()
	local restrict = ui_get(semirage.dynamicfov_restrict)

	if not restrict then
		DynamicFOV()
	end
	DynamicFOV_drawing()
end
client_set_event_callback('paint', dynamicfov_paint)
---------------------

---[ Function #4 ]---
local function vec2_dist(f_x, f_y, t_x, t_y)
    local delta_x, delta_y = f_x - t_x, f_y - t_y
    return math_sqrt( delta_x * delta_x + delta_y * delta_y )
end

local function get_all_player_locations(w, h, enemy)
	local indexes = {}
	local positions = {}
	local players = entity_get_players(enemy)
	if #players == 0 or not #players then 
		return 
	end
	
	for i = 1, #players do
		local p = players[i]
		
		local px, py, pz = entity_get_prop(p, 'm_vecOrigin')
		local vz = entity_get_prop(p, 'm_vecViewOffset[2]')
		
		if pz ~= nil and vz ~= nil then
			pz = pz + (vz * 0.5)
			local sx, sy = renderer_world_to_screen(px, py, pz)
			if sx ~= nil and sy ~= nil then
				if sx >= 0 and sx < w and sy >= 0 and sy <= h then
                    indexes[#indexes + 1] = p
                    positions[#positions + 1] = {sx, sy}
                end
			end
		end
	end
	
	return indexes, positions
end

local function check_fov()
    local w, h = client_screen_size()
    local sx, sy = w * 0.5, h * 0.5
    local fov_limit = 250

    if get_all_player_locations(w, h, true) == nil then return end

    local enemy_indexes, enemy_coords = get_all_player_locations(w, h, true)
    if #enemy_indexes <= 0 then return true end
    if #enemy_coords == 0 then return true end

    local closest_fov = 133337
    local closest_entindex = 133337
    for i=1, #enemy_coords do
        local x = enemy_coords[i][1]
        local y = enemy_coords[i][2]

        local cur_fov = vec2_dist(x, y, sx, sy)
        if cur_fov < closest_fov then
            closest_fov = cur_fov
            closest_entindex = enemy_indexes[i]
        end
    end

    return closest_fov > fov_limit, closest_entindex
end

local function enable_penetration_shotme()
	vars.penetration_shotme = true
end

local function disable_penetration_shotme()
	vars.penetration_shotme = false
end

local function penetration_shotme(e)
	local userid = e.userid
	local entindex = client_userid_to_entindex(userid)
	if entindex == entity_get_local_player() then
		local shot_me = table_contains(ui_get(semirage.penetration_mode[1]), 'Shot me')

		if not shot_me then
			vars.penetration_shotme = false
			return
		end

		client_delay_call(ui_get(semirage.penetration_delay_turnson), enable_penetration_shotme)
		client_delay_call(ui_get(semirage.penetration_delay_stayson), disable_penetration_shotme)
	end

end
client_set_event_callback('player_hurt', penetration_shotme)

client_set_event_callback('paint', function()
	local on_hotkey = table_contains(ui_get(semirage.penetration_mode[1]), 'Visible')

	if on_hotkey then
		local enemy_visible, enemy_entindex = check_fov()
		if enemy_entindex == nil then 
			return 
		end
        if enemy_visible and enemy_entindex ~= nil and vars.cached_target ~= enemy_entindex then 
            vars.cached_target = enemy_entindex
        end
        local _ = can_see(enemy_entindex)
        if _ then 
            vars.visible = true
        else 
            vars.visible = false
        end
		vars.cached_target = enemy_entindex
	else
		vars.visible = false
	end

	if vars.penetration_shotme or vars.penetration or vars.visible then
		ui_set(rage.penetration, true)
	else
		ui_set(rage.penetration, false)
	end
end)

client_set_event_callback('round_start', function()
	vars.visible = false
	vars.penetration = false
	vars.penetration_shotme = false
	vars.name_player = nil
end)
---------------------

---[ Function #5 ]---
local frametimes = {}
local fps_prev = 0
local last_update_time = 0

local function AccumulateFps()
	local ft = globals_absoluteframetime()
	if ft > 0 then
		table_insert(frametimes, 1, ft)
	end
	local count = #frametimes
	if count == 0 then
		return 0
	end
	local i, accum = 0, 0
	while accum < 0.5 do
		i = i + 1
		accum = accum + frametimes[i]
		if i >= count then
			break
		end
	end
	accum = accum / i
	while i < count do
		i = i + 1
		table_remove(frametimes)
	end
	local fps = 1 / accum
	local rt = globals_realtime()
	if math_abs(fps - fps_prev) > 4 or rt - last_update_time > 2 then
		fps_prev = fps
		last_update_time = rt
	else
		fps = fps_prev
	end
	return math_floor(fps + 0.5)
end

local function Sync()
	local indicators = ui_get(legitaa.indicators[1])
	local arrow = table_contains(indicators, 'Arrow')
	local text = table_contains(indicators, 'Text')

	vars.legitaa_value1 = arrow
	vars.legitaa_value2 = text

end

local function Sync2()
	local mode = ui_get(legitaa.auto_off[1])
	local show_slider = table_contains(mode, 'Show sliders')
	local fps_slider = table_contains(mode, 'FPS')
	local ping_slider = table_contains(mode, 'Ping')
	local speed_slider = table_contains(mode, 'Speed')
	local loss_slider = table_contains(mode, 'Loss')
	local choke_slider = table_contains(mode, 'Choke')

	vars.legitaa_show_slider = show_slider
	vars.legitaa_fps_slider = fps_slider
	vars.legitaa_ping_slider = ping_slider
	vars.legitaa_speed_slider = speed_slider
	vars.legitaa_loss_slider = loss_slider
	vars.legitaa_choke_slider = choke_slider

end

local function HandleMenu()

	local enabled = ui_get(legitaa.enabled)
	local check = vars.legitaa_check

	if enabled then
		check = true
		client_delay_call(0.1, function()
			oldcfg = ui_get(misc.cfg[1])
		end)
		ui_set(aa.antiaim[1], true)
		ui_set(aa.pitch[1], 'Off')
		ui_set(aa.yaw_base[1], 'Local view')
		ui_set(aa.yaw[1], 'Off')
		ui_set(aa.yaw[2], 0)
		ui_set(aa.yaw_jitter[1], 'Off')
		ui_set(aa.yaw_jitter[2], 0)
		ui_set(aa.body_yaw[1], 'Static')
		ui_set(aa.fake_yaw_limit[1], 60)
		ui_set(aa.edge_yaw, false)
		ui_set(aa.fs[1], '-')
		ui_set(fl.fakelag[1], false)
		ui_set(fl.limit, 6)
		ui_set(semirage.hide_useless_features, true)
	else
		if check then
			check = false
			if oldcfg == ui_get(misc.cfg) then
				ui_set(aa.antiaim[1], false)
			end
		end
		ui_set(semirage.hide_useless_features, false)
	end
	Sync()
	Sync2()
end

local function conditions()
	local stop_1 = vars.legitaa_stop1
	local stop_2 = vars.legitaa_stop2
	local stop_3 = vars.legitaa_stop3
	local stop_4 = vars.legitaa_stop4
	local stop_5 = vars.legitaa_stop5

	if stop_1 then
		ui_set(aa.antiaim[1], false)
	elseif stop_2 then
		ui_set(aa.antiaim[1], false)
	elseif stop_3 then
		ui_set(aa.antiaim[1], false)
	elseif stop_4 then
		ui_set(aa.antiaim[1], false)
	elseif stop_5 then
		ui_set(aa.antiaim[1], false)
	else
		ui_set(aa.antiaim[1], true)
	end
end

HandleMenu()
ui_set_callback(legitaa.enabled, HandleMenu)

ffi.cdef[[
    typedef void*(__thiscall* get_net_channel_info_t)(void*);
    typedef const char*(__thiscall* get_name_t)(void*);
    typedef const char*(__thiscall* get_address_t)(void*);
    typedef float(__thiscall* get_local_time_t)(void*);
    typedef float(__thiscall* get_time_connected_t)(void*);
    typedef float(__thiscall* get_avg_latency_t)(void*, int);
    typedef float(__thiscall* get_avg_loss_t)(void*, int);
    typedef float(__thiscall* get_avg_choke_t)(void*, int);
]]

local interface_ptr = ffi.typeof('void***')
local rawivengineclient = client_create_interface('engine.dll', 'VEngineClient014') or error('VEngineClient014 wasnt found', 2)
local ivengineclient = ffi.cast(interface_ptr, rawivengineclient) or error('rawivengineclient is nil', 2)
local get_net_channel_info = ffi.cast('get_net_channel_info_t', ivengineclient[0][78]) or error('ivengineclient is nil')
local FLOW_OUTGOING = 0
local FLOW_INCOMING	= 1
local MAX_FLOWS = 2

client_set_event_callback('paint', function()
	if not ui_get(legitaa.enabled) then
		return
	end

	local netchaninfo = ffi.cast('void***', get_net_channel_info(ivengineclient))
	local get_avg_loss = ffi.cast('get_avg_loss_t', netchaninfo[0][11])
	local get_avg_choke = ffi.cast('get_avg_choke_t', netchaninfo[0][12])
	local Tickrate = 1 / globals_tickinterval()
	local vx, vy = entity_get_prop(entity_get_local_player(), 'm_vecVelocity')
	local r, g, b, a = ui_get(legitaa.indicators_color)
	local r2, g2, b2, a2 = ui_get(legitaa.arrows_color)

	local x, y = client_screen_size()
	local ping = math_floor(client_latency()*1000)
	local loss = get_avg_loss(netchaninfo, FLOW_INCOMING)
	local choke = get_avg_choke(netchaninfo, FLOW_INCOMING)
	local enabled = ui_get(aa.antiaim[1])
	local hotkey = ui_get(legitaa.legitaa_key)
	local fs_body = ui_get(aa.fs_body_yaw)

	local value1 = vars.legitaa_value1
	local value2 = vars.legitaa_value2

	local slider1 = vars.legitaa_fps_slider
	local slider2 = vars.legitaa_ping_slider
	local slider3 = vars.legitaa_speed_slider
	local slider4 = vars.legitaa_loss_slider
	local slider5 = vars.legitaa_choke_slider

	if vx ~= nil then
		speed = math_floor(math_sqrt(vx*vx + vy*vy + 0.5))
	end

	if (ui_get(legitaa.aa_mode[1]) == 'Safe') then
		ui_set(aa.body_yaw_target[1], 'Eye yaw')
	elseif (ui_get(legitaa.aa_mode[1]) == 'Maximum') then
		ui_set(aa.body_yaw_target[1], 'Opposite')
	end

	if value1 then
		if hotkey then
			renderer_text(x/2-60, y/2, r, g, b, a, '+cd', 0, '⮜')
			if ui_get(legitaa.both_arrows) then
				renderer_text(x/2+60, y/2, r2, g2, b2, a2, '+cd', 0, '⮞')
			end
		else
			renderer_text(x/2+60, y/2, r, g, b, a, '+cd', 0, '⮞')
			if ui_get(legitaa.both_arrows) then
				renderer_text(x/2-60, y/2, r2, g2, b2, a2, '+cd', 0, '⮜')
			end
		end
	end

	if value2 then
		if not fs_body then
			if hotkey then
				renderer_indicator(r, g, b, a, 'LEFT')
			else
				renderer_indicator(r, g, b, a, 'RIGHT')
			end
		end
	end

	if fs_body and enabled then
		ui_set(aa.body_yaw[1], 'Opposite')
		ui_set_visible(legitaa.legitaa_key, false)
		ui_set(legitaa.indicators[1], 'Text')
		renderer_indicator(r, g, b, a, 'DYNAMIC')
	else
		ui_set_visible(legitaa.legitaa_key, true)
		if hotkey then
			ui_set(aa.body_yaw[2], 60)
			ui_set(aa.body_yaw[1], 'Static')
		else
			ui_set(aa.body_yaw[2], -60)
			ui_set(aa.body_yaw[1], 'Static')
		end
	end

	if slider1 then
		if (ui_get(legitaa.fps_slider) == 59) then
			if(AccumulateFps() < Tickrate) then
				vars.legitaa_stop1 = true
			else
				vars.legitaa_stop1 = false
			end
		else
			if(AccumulateFps() < ui_get(legitaa.fps_slider)) then
				vars.legitaa_stop1 = true
			else
				vars.legitaa_stop1 = false
			end
		end
	else
		vars.legitaa_stop1 = false
	end

	if slider2 then
		if (ping > (ui_get(legitaa.ping_slider))) then
			vars.legitaa_stop2 = true
		else
			vars.legitaa_stop2 = false
		end
	else
		vars.legitaa_stop2 = false
	end

	if slider3 then
		if (speed > (ui_get(legitaa.speed_slider))) then
			vars.legitaa_stop3 = true
		else
			vars.legitaa_stop3 = false
		end
	else
		vars.legitaa_stop3 = false
	end

	if slider4 then
		if (loss > (ui_get(legitaa.loss_slider))) then
			vars.legitaa_stop4 = true
		else
			vars.legitaa_stop4 = false
		end
	else
		vars.legitaa_stop4 = false
	end

	if slider5 then
		if (choke > (ui_get(legitaa.choke_slider))) then
			vars.legitaa_stop5 = true
		else
			vars.legitaa_stop5 = false
		end
	else
		vars.legitaa_stop5 = false
	end

	Sync()
	Sync2()
	conditions()
end)
---------------------

---[ Function #6 ]---
local function time_to_ticks(t)
	return math_floor(0.5 + (t / globals_tickinterval()))
end

local hitgroups_names = { 'generic', 'head', 'chest', 'stomach', 'left arm', 'right arm', 'left leg', 'right leg', 'neck', '?', 'gear' }

local function on_fire(e)
	local logs = ui_get(semirage.advanced_logs) and table_contains(ui_get(semirage.logs_mode[1]), 'Fire')

	if logs and e ~= nil then
		local flags = { e.teleported and 'T' or '', e.interpolated and 'I' or '', e.extrapolated and 'E' or '', e.boosted and 'B' or '', e.high_priority and 'H' or '' }
		local group = hitgroups_names[e.hitgroup + 1] or '?'

		client_log(string_format('Fired at %s in the %s for %d damage (hitchance = %d%%, bt=%2d, flags=%s)', entity_get_player_name(e.target), group, e.damage, math_floor(e.hit_chance + 0.5), time_to_ticks(e.backtrack), table_concat(flags)))
	end
end
client_set_event_callback('aim_fire', on_fire)

local function on_hit(e)
	local logs = ui_get(semirage.advanced_logs) and table_contains(ui_get(semirage.logs_mode[1]), 'Hit')

	if logs and e ~= nil then
		local group = hitgroups_names[e.hitgroup + 1] or '?'

		client_log(string_format('Hit %s in the %s for %d damage (%d health remaining)', entity_get_player_name(e.target), group, e.damage, entity_get_prop(e.target, 'm_iHealth')))
	end
end
client_set_event_callback('aim_hit', on_hit)

local function on_miss(e)
	local logs = ui_get(semirage.advanced_logs) and table_contains(ui_get(semirage.logs_mode[1]), 'Miss')

	if logs and e ~= nil then
		local group = hitgroups_names[e.hitgroup + 1] or '?'
		local reason 

		if e.reason == '?' then
			reason = 'unknown'
		else
			reason = e.reason
		end

		client_log(string_format('Missed %s in the %s due to %s', entity_get_player_name(e.target), group, reason))
	end
end
client_set_event_callback('aim_miss', on_miss)
---------------------


local err = client_set_event_callback('miss', on_miss)
        end


        function _M.auth()
            authed = true
            body()
        end


        local function onLoad()
            if(authed)then
                client.log("[" .. luaName .. "]Authed, welcome")
            else
                client.log("[" .. luaName .. "]You can't use this lua, sorry")
            end
        end

        client.delay_call(3,onLoad)

        return _M