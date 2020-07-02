--local ffi = require("ffi")
--local sig = client.find_signature("engine.dll", "\x53\x56\x57\x8B\xDA\x8B\xF9\xFF\x15")
--local fn = ffi.cast(ffi.typeof("int(__fastcall*)(const char*, const char*)"), sig)
--function client.set_clan_tag(tag)
--    fn(tag, tag)
--end

--local get_local_player = entity.get_local_player
--local entity_get_prop = entity.get_prop
--local client_set_clan_tag = client.set_clan_tag
--local oldTick = globals.tickcount()
--local gamesense_origin = ui.reference("MISC", "Miscellaneous", "Clan tag spammer")
--local TwinTowerClantag = {"注入中","注入中.","注入中..", "注入中...", "注入中....", "注入中...", "注入中..", "注入中.", "注入中", "注入中▁︎", "注入中▂︎", "注入中▃︎", "注入中▅︎", "注入中▇︎","[注入成功]", "\xE2\x98\xA0The Best\xE2\x98\xA0",}


--local cur = 1

--local function get_twint(e)
--    if globals.tickcount() - oldTick > 55 then
--        ui.set(gamesense_origin,false)
--        cur = math.floor(globals.curtime() % 17 + 1)
--        client_set_clan_tag(TwinTowerClantag[cur])
--        oldTick = globals.tickcount()
--    end

--end
--client.set_event_callback("player_connect_full", function(e)
    oldTick = globals.tickcount()
--end)
--client.set_event_callback("paint", get_twint)