local client_set_clan_tag = client.set_clan_tag
local oldTick = globals.tickcount()
local clan_enable = ui.new_checkbox("MISC", "Miscellaneous", "clantag")
local Clantag = {
"|",
"|\\",
"|\\|",
"N",
"N3",
"Ne",
"Ne\\",
"Ne\\/",
"Nev",
"Nev3",
"Neve",
"Neve|",
"Neve|2",
"Never",
"Never|",
"Neverl",
"Neverl0",
"Neverlo",
"Neverlo5",
"Neverlos",
"Neverlos3",
"Neverlose",
"Neverlose.",
"Neverlose.<",
"Neverlose.c",
"Neverlose.c<",
"Neverlose.cc",
"Neverlose.cc",
"Neverlose.c<",
"Neverlose.c",
"Neverlose.<",
"Neverlose.",
"Neverlose",
"Neverlos3",
"Neverlos",
"Neverlo5",
"Neverlo",
"Neverl0",
"Neverl",
"Never|",
"Never",
"Neve|2",
"Neve|",
"Neve",
"Nev3",
"Nev",
"Ne\\/",
"Ne\\",
"Ne",
"N3",
"N",
"|\\|",
"|\\",
"|",
} 

local function get_clan(e)
    if (ui.get(clan_enable)) then
        if globals.tickcount() - oldTick > 64 then
            cur = math.floor(globals.curtime() % #Clantag + 1)
            client_set_clan_tag(Clantag[cur])
            oldTick = globals.tickcount()
        end
    end
end
client.set_event_callback("player_connect_full", function(e)
    oldTick = globals.tickcount()
end)

client.set_event_callback("paint", get_clan)
client.set_event_callback(clan_enable, function(e)
	if not ui.get(clan_enable) then
		client_set_clan_tag(' ')
	end
end)