--- @author NaturalHG ---
--- Mamoe Dev. Team   ---
--- github.com/mamoe  ---

local client_set_event_callback, ui_get, ui_new_checkbox, ui_reference, ui_set = client.set_event_callback, ui.get, ui.new_checkbox, ui.reference, ui.set
local set, get = ui.set, ui.get
local time = globals.curtime

local controls = {
    indicators      = ui.new_label("Config", "Presets", "o───────────────────────────────o"),
    indicators      = ui.new_label("Config", "Presets", "                      CFG BY KIM                      "),
    indicators      = ui.new_label("Config", "Presets", "                      LUA BY KIM                      "),
    indicators      = ui.new_label("Config", "Presets", "                     泄露 停更 封SK                    "),
    indicators      = ui.new_label("Config", "Presets", "                KIM QQ: 451374144                "),
    indicators      = ui.new_label("Config", "Presets", "o───────────────────────────────o"),
    indicators      = ui.new_label("RAGE", "Aimbot", "o───────────────────────────────o"),
    indicators      = ui.new_label("RAGE", "Aimbot", "                      CFG BY KIM                      "),
    indicators      = ui.new_label("RAGE", "Aimbot", "                      LUA BY KIM                      "),
    indicators      = ui.new_label("RAGE", "Aimbot", "                     泄露 停更 封SK                    "),
    indicators      = ui.new_label("RAGE", "Aimbot", "                KIM QQ: 451374144                "),
    indicators      = ui.new_label("RAGE", "Aimbot", "o───────────────────────────────o"),
    indicators      = ui.new_label("RAGE", "Other", "o───────────────────────────────o"),
    indicators      = ui.new_label("RAGE", "Other", "                      CFG BY KIM                      "),
    indicators      = ui.new_label("RAGE", "Other", "                      LUA BY KIM                      "),
    indicators      = ui.new_label("RAGE", "Other", "                     泄露 停更 封SK                    "),
    indicators      = ui.new_label("RAGE", "Other", "                KIM QQ: 451374144                "),
    indicators      = ui.new_label("RAGE", "Other", "o───────────────────────────────o"),
    indicators      = ui.new_label("AA", "anti-aimbot angles", "o───────────────────────────────o"),
    indicators      = ui.new_label("AA", "anti-aimbot angles", "                      CFG BY KIM                      "),
    indicators      = ui.new_label("AA", "anti-aimbot angles", "                      LUA BY KIM                      "),
    indicators      = ui.new_label("AA", "anti-aimbot angles", "                     泄露 停更 封SK                    "),
    indicators      = ui.new_label("AA", "anti-aimbot angles", "                KIM QQ: 451374144                "),
    indicators      = ui.new_label("AA", "anti-aimbot angles", "o───────────────────────────────o"),
    indicators      = ui.new_label("LUA", "B", "o───────────────────────────────o"),
    indicators      = ui.new_label("LUA", "B", "                      CFG BY KIM                      "),
    indicators      = ui.new_label("LUA", "B", "                      LUA BY KIM                      "),
    indicators      = ui.new_label("LUA", "B", "                     泄露 停更 封SK                    "),
    indicators      = ui.new_label("LUA", "B", "                KIM QQ: 451374144                "),
    indicators      = ui.new_label("LUA", "B", "o───────────────────────────────o")
}

-- 抄来的Ref
local pitch = ui.reference("AA", "Anti-aimbot angles", "Pitch")
local base = ui.reference("AA", "Anti-aimbot angles", "Yaw base")
local yaw, yaw_slider = ui.reference("AA", "Anti-aimbot angles", "Yaw")
local jitter, jitter_slider = ui.reference("AA", "Anti-aimbot angles", "Yaw jitter")
local bodyyaw, bodyyaw_slider = ui.reference("AA", "Anti-aimbot angles", "Body Yaw")
local lbytarget = ui.reference("AA", "Anti-aimbot angles", "Lower body yaw target")
local limit = ui.reference("AA", "Anti-aimbot angles", "Fake Yaw Limit")
local slowmo, slowmo_key = ui.reference("AA", "Other", "Slow motion")
local fakeduck = ui.reference("RAGE","Other","Duck peek assist")

local fakelag_enable, fakelag_key = ui.reference("AA", "Fake lag", "Enabled")
local fakelag_type = ui.reference("AA","Fake lag","Amount")
local fakelag_veriance = ui.reference("AA","Fake lag","Variance")
local fakelag_limit =ui.reference("AA","Fake lag","Limit")
local onshotaa, onshotaakey = ui.reference("AA", "Other", "On shot anti-aim")
local doubletap, doubletapkey = ui.reference("RAGE", "Other", "Double tap")

local autowall = ui.reference("RAGE", "Aimbot", "Automatic Penetration")
local ragebot_maximum_fov = ui.reference("RAGE", "Aimbot", "Maximum FOV")
local rage_hitbox = ui.reference("RAGE", "Aimbot", "Target hitbox")
local aimstep = ui.reference("RAGE", "Aimbot", "Reduce aim step")




local function normalizeYaw(_yaw)
    if(_yaw == nil)then
        return 0
    end
    while _yaw > 180 do
        _yaw = _yaw - 360
    end

    while _yaw < -180 do
        _yaw = _yaw + 360
    end

    return _yaw
end


local menuData = {
    mode = ui.new_combobox("AA", "Anti-aimbot angles", "Best KIM DesyncV3", "Off", "Rage-HVH","Rage-Official"),

    left_key = ui.new_hotkey("AA", "Anti-aimbot angles", "AA Left Key", false),
    right_key = ui.new_hotkey("AA", "Anti-aimbot angles", "AA Right Key", false),
    invert_key = ui.new_hotkey("AA", "Anti-aimbot angles", "AA Invert Key", false),
    desync_key = ui.new_hotkey("AA", "Anti-aimbot angles", "AA Desync Key", false),

    slowMotionLimit = ui.new_slider("AA", "Other", "Slow motion limit", 10, 57, 50, 57, "", 1, {
        [57.0] = "Max"
    });

    --onshot_tick = ui.new_slider("AA", "Anti-aimbot angles", "On Shot [X] Tick", 10, 256),

    --hide_menu = ui.new_combobox("LUA", "B", "RESET", "O", "Z"),
}

local kimAA = {
    isEnable = function()
        return (get(menuData.mode) ~= "Off")
    end,
    isHvhServer = function()
        return (get(menuData.mode) ~= "Rage-HVH")
    end
}

---这里是Official的数据
local hvhDataSet = {
    ["Standing"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = {0,2,4,5,6,7,8,14,0,2,4,5,6,7,8,14,0,2,4,5,6,7,8,14,0,2,4,5,6,7,8,14,0,2,4,5,6,7,8,14,0},
        ["jitter"] = "off",
        ["jitterValue"] = {-130},
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = {180,180,180,-180,-180,-180,180},
        ["lbyTarget"] = {"Opposite"},
        ["limit"] = {60}
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = {0,0,0,0,0,0,0,0,0,120,0,0,0,0,0,0,0,0,0,-87,0,0,0,0,0,0,0,0,0,120,0,0,0,0,0,0,0,0,0,-87,0,0,0,0,0,0,0,0,0,120,0,0,0,0,0,0,0,0,0,-87,0,0,0,0,0,0,0,0,0,120},
        ["jitter"] = "off",
        ["jitterValue"] = {-130},
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = {180},
        ["lbyTarget"] = {"Opposite","Opposite","Eye yaw","Eye yaw","Eye yaw","Opposite","Opposite"},
        ["limit"] = {60}
        },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = {-8,8,-10},
        ["jitter"] = "Random",
        ["jitterValue"] = {0,8,-10,12},
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = {0,30,-180},
        ["lbyTarget"] = {"Off","Opposite","Eye yaw","Opposite","Eye yaw","Off"},
        ["limit"] = {60,40,30,50},
        },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = {-8,8,-10},
        ["jitter"] = "Random",
        ["jitterValue"] = {0,8,-10,12},
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = {0,30,-180},
        ["lbyTarget"] = {"Off","Opposite","Eye yaw","Opposite","Eye yaw","Off"},
        ["limit"] = {60,40,30,50},
        },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = {14,14,14,20,14,14,14,20,14,14,20,20},
        ["jitter"] = "Offset",
        ["jitterValue"] = {-4},
        ["bodyYaw"] = "Jitter",
        ["bodyYawValue"] = {95,-95},
        ["lbyTarget"] = {"Opposite"},
        ["limit"] = {60},
    },
}

---这里是HVH的数据
local officialDataSet = {
    ["Standing"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = {45,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8},
        ["jitter"] = "off",
        ["jitterValue"] = {-0},
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = {180,-180,-180,-180,-180,-180,-180,-180,-180,-180,-180,-180,-180,-180,-180,-180,-180,-180,-180,-180,-180},
        ["lbyTarget"] = {"Opposite"},
        ["limit"] = {60}
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = {-8},
        ["jitter"] = "off",
        ["jitterValue"] = {0},
        ["bodyYaw"] = "Jitter",
        ["bodyYawValue"] = {-90},
        ["lbyTarget"] = {"Eye yaw"},
        ["limit"] = {60}
        },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = {0,0,0,-8,8,-10},
        ["jitter"] = "Random",
        ["jitterValue"] = {0,8,-10,12},
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = {0,30,-180},
        ["lbyTarget"] = {"Off","Opposite","Eye yaw","Opposite","Eye yaw","Off"},
        ["limit"] = {60,40,30,50},
        },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = {-8,8,-10},
        ["jitter"] = "Random",
        ["jitterValue"] = {0,8,-10,12},
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = {0,30,-180},
        ["lbyTarget"] = {"Off","Opposite","Eye yaw","Opposite","Eye yaw","Off"},
        ["limit"] = {60,40,30,50},
        },
    ["SlowMotion"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = {45,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8},
        ["jitter"] = "off",
        ["jitterValue"] = {0},
        ["bodyYaw"] = "Jitter",
        ["bodyYawValue"] = {-90},
        ["lbyTarget"] = {"Opposite"},
        ["limit"] = {45,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60,60}
        },
}

local lastLimitIndex = 1
local lastLbyTargetIndex = 1
local lastBodyYawValueIndex = 1
local lastJitterValueIndex = 1
local lastYawValueIndex = 1


local SKMenu = {
    show = function(visible)
        ui.set_visible(pitch,visible)
        ui.set_visible(base,visible)
        ui.set_visible(yaw,visible)
        ui.set_visible(yaw_slider,visible)
        ui.set_visible(jitter,visible)
        ui.set_visible(jitter_slider,visible)
        ui.set_visible(bodyyaw,visible)
        ui.set_visible(bodyyaw_slider,visible)
        ui.set_visible(lbytarget,visible)
        ui.set_visible(limit,visible)
    end,
    import = function(_pitch,_yaw,_yaw_slider,_jitter,_jitter_slider,_body_yaw,_bodyyaw_slider,_lbytarget,_limit)
        if(lastLimitIndex > #_limit)then
             lastLimitIndex = 1
        end

        if(lastLbyTargetIndex > #_lbytarget)then
             lastLbyTargetIndex = 1
        end

        if(lastJitterValueIndex > #_jitter_slider)then
            lastJitterValueIndex = 1
        end

        set(pitch,_pitch)
        set(yaw,_yaw)
        set(yaw_slider, normalizeYaw(_yaw_slider))
        if(_jitter ~= nil)then
            set(jitter, _jitter)
        end
        set(jitter_slider, _jitter_slider[lastJitterValueIndex])
        set(bodyyaw, _body_yaw)
        set(bodyyaw_slider,normalizeYaw(_bodyyaw_slider))
        set(lbytarget,_lbytarget[lastLbyTargetIndex])
        --set(limit, _limit)
        --limit become a array(data set) in May22
        set(limit,_limit[lastLimitIndex])





        lastLimitIndex = lastLimitIndex + 1
        lastJitterValueIndex = lastJitterValueIndex + 1
        lastLbyTargetIndex = lastLbyTargetIndex + 1

    end
}

local state = "Standing"
local isFacingLeft  = false;
local isFacingRight = false;
local lastLeftStatus  = false;
local lastRightStatus = false;
local entity_get_prop = entity.get_prop
local entity_get_local_player = entity.get_local_player
local entity_get_player_weapon = entity.get_player_weapon
local shouldFlip = false
local lastDesync = false
local function getShouldFlip() if(shouldFlip)then shouldFlip = false return true end return false end

local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local lastShotCountDown = 0

local function updateState(cm)

    ---- todo rewrite
    if(not get(menuData.left_key) == lastLeftStatus) then
        lastLeftStatus = get(menuData.left_key)
        if(isFacingLeft == true)then
            isFacingLeft = false
        else
            isFacingLeft = true
            isFacingRight = false
        end
    end
    if(not get(menuData.right_key) == lastRightStatus) then
        lastRightStatus = get(menuData.right_key)
        if(isFacingRight == true)then
            isFacingRight = false
        else
            isFacingRight = true
            isFacingLeft = false
        end
    end
    ----

    local me = entity_get_local_player()

    local flags = entity_get_prop(me, "m_fFlags")
    local x, y, z = entity_get_prop(me, "m_vecVelocity")
    local velocity = math.floor(math.min(10000, math.sqrt(x^2 + y^2) + 0.5))

    if get(slowmo) and get(slowmo_key) then
        state = "SlowMotion"
    elseif bit.band(flags, 2) == 2 then
        state = "Crouching"
    elseif bit.band(flags, 1) ~= 1 or (cm and cm.in_jump == 1) then
        state = "InAir"
    elseif velocity > 1.1 then--local server
        state = "Moving"
    else
        state = "Standing"
    end

    local weapon_fired_time = entity_get_prop(entity_get_player_weapon(entity_get_local_player()), "m_fLastShotTime")
    if(weapon_fired_time ~= nil) then
        if round(time(), 1) == round(weapon_fired_time, 1) then
            -- just shot
            lastShotCountDown = 48
        end
    end

    lastShotCountDown = lastShotCountDown - 1
end

local function random_or(a,b)
    if(math.random() > 0.5)then
        return a
    else
        return b
    end
end

local AAProcessor = {
    preTick = function(e)
        if(state == "SlowMotion")then
            local goalspeed = get(menuData.slowMotionLimit)
            if goalspeed <= 0 then
                return
            end

            local minimalspeed = math.sqrt((e.forwardmove * e.forwardmove) + (e.sidemove * e.sidemove))

            if minimalspeed <= 0 then
                return
            end

            if e.in_duck == 1 then
                goalspeed = goalspeed * 2.94117647
            end

            if minimalspeed <= goalspeed then
                return
            end
            local speedfactor = goalspeed / minimalspeed
            e.forwardmove = e.forwardmove * speedfactor
            e.sidemove = e.sidemove * speedfactor
        end
    end,

    onTick = function()
        --fakelag
        if(get(doubletapkey) and get(doubletap))then
            set(fakelag_enable,false)
        else
            set(fakelag_enable,true)
            if(get(fakeduck))then
                set(fakelag_veriance,0)
                set(fakelag_limit,14)
            else
                if(lastShotCountDown > 0)then

                    if(not kimAA.isHvhServer())then ---开枪，hvh的
                        set(fakelag_type,"Maximum")
                        set(fakelag_veriance,17)
                        set(fakelag_limit,random_or(14,14))
                    else                          
                        set(fakelag_type,"Fluctuate")---开枪，官匹的
                        set(fakelag_veriance,0)
                        set(fakelag_limit,random_or(14,14))
                    end

                elseif(((time()*1000)%10) == 0)then
                    if(not kimAA.isHvhServer())then---hvh的
                        if(get(menuData.desync_key))then
                            set(fakelag_type,"Maximum")
                            set(fakelag_veriance,17)
                            set(fakelag_limit,random_or(14,14))
                        else
                            set(fakelag_limit,random_or(14,14))
                            set(fakelag_type,"Maximum")
                            set(fakelag_veriance,17)
                        end
                    else---官匹的
                        if(get(menuData.desync_key))then
                            set(fakelag_type,"Dynamic")
                            set(fakelag_veriance,9)
                            set(fakelag_limit,random_or(5,5))
                        else
                            set(fakelag_limit,random_or(5,5))
                            set(fakelag_veriance,9)
                        end
                    end
                end
            end
        end

        --AA
        local data = nil
        if(kimAA.isHvhServer())then
            data = hvhDataSet[state]
        else
            data = officialDataSet[state]
        end

        if(lastYawValueIndex > #data["yawValue"]) then
            lastYawValueIndex = 1
        end

        if(lastBodyYawValueIndex > #data["bodyYawValue"])then
            lastBodyYawValueIndex = 1
        end


        local processBodyYaw = data["bodyYawValue"][lastBodyYawValueIndex]

        local invert = get(menuData.invert_key)
        if(get(menuData.desync_key))then--check desync
            if(getShouldFlip())then
                lastDesync = not lastDesync
            end
            invert = lastDesync
        end

        if(invert)then
            processBodyYaw = 0 - processBodyYaw
        end


        local manual_aa_direction_parm = 0
        if(isFacingLeft == true) then
            manual_aa_direction_parm = -110
        end
        if(isFacingRight == true) then
            manual_aa_direction_parm = 120
        end


        local processYaw = data["yawValue"][lastYawValueIndex]

        if(manual_aa_direction_parm ~= 0)then
            set(base, "Local view")
            processYaw = normalizeYaw(processYaw  + manual_aa_direction_parm)
        else
            set(base, "Local view")
        end

        lastYawValueIndex = lastYawValueIndex + 1
        lastBodyYawValueIndex = lastBodyYawValueIndex + 1

        SKMenu.import(
                data["pitch"],
                data["yaw"],
                processYaw,
                data["jitter"],
                data["jitterValue"],
                data["bodyYaw"],
                processBodyYaw,
                data["lbyTarget"],
                data["limit"]
        )
    end
}

local function on_player_hurt(e) shouldFlip = true end
local function on_bullet_impact(e) shouldFlip = true end
client.set_event_callback("player_hurt", on_player_hurt)
client.set_event_callback("bullet_impact", on_bullet_impact)
client.set_event_callback("run_command", function(e)
    if(not kimAA.isEnable())then
        SKMenu.show(true)
        return
    end
    --if(get(menuData.hide_menu) ~= "Z")then
        SKMenu.show(false)
    --end
    updateState(e)
    AAProcessor.onTick()
end)

local function on_setup_cmd(cmd)
    if(not kimAA.isEnable())then
        return
    end
    AAProcessor.preTick(cmd)
end

client.set_event_callback('setup_command', on_setup_cmd)
local measure_text = renderer.measure_text
local renderer_text = renderer.text
local renderer_indicator = renderer.indicator

local lastR = 128
local lastG = 255
local lastB = 0

local function getNextRGB(current_)
    local current = current_
    current = current +  math.random(0,4)-2
    if(current > 255)then
        current = 230
    end
    if(current < 0)then
        current = 20
    end
    return current
end

local drawerHelper = {
    indicator = function(index,r,g,b,a,text)
        if(method == 0)then
            return renderer.indicator(r,g,b,a,text)
        end
        local x,y = client.screen_size()
        local textBase = "|"
        local textBaseFlag = "+b"
        local width, height = measure_text(textBaseFlag,textBase)
        height = height * index
        renderer_text(17, y - height, r,g,b,a, textBaseFlag, 0, text)
        return y - height
    end,
    randomColor = {
        getR = function()
            lastR =  getNextRGB(lastR)
            return lastR
        end,
        getG = function()
            lastG = getNextRGB(lastG)
            return lastG
        end,
        getB = function()
            lastB = getNextRGB(lastB)
            return lastB
        end
    },
    indicator = function(index,r,g,b,a,text)
        local x,y = client.screen_size()
        local textBase = "|"
        local textBaseFlag = "+b"
        local width, height = measure_text(textBaseFlag,textBase)
        height = height * index
        renderer_text(17, y - height, r,g,b,a, textBaseFlag, 0, text)
        return y - height
    end,
}

local function onPaint()
    if(not kimAA.isEnable())then
        return
    end

    local lastY = 0
    if(isFacingRight or isFacingLeft)then
        lastY = drawerHelper.indicator(3,drawerHelper.randomColor.getR(),drawerHelper.randomColor.getG(),drawerHelper.randomColor.getB(),255,"Best KIM - Manual")
    else
        lastY = drawerHelper.indicator(3,drawerHelper.randomColor.getR(),drawerHelper.randomColor.getG(),drawerHelper.randomColor.getB(),255,"Best KIM - Auto")
    end
    local index = 4
    if(get(menuData.desync_key))then
        drawerHelper.indicator(index,126,255,220,255,"Best KIM - DESYNC")
        index = index+1
    end
    if(get(menuData.invert_key))then
        drawerHelper.indicator(index,50,255,95,255,"Best KIM - Invert")
        index = index+1
    end
    renderer.rectangle(20, lastY + 27, 42, 5, 0, 0, 0, 100)
    renderer.rectangle(21, lastY + 27, ((40 / 14.1) * (get(fakelag_limit))), 4, 255, 180, 61, 255)

    local x,y = client.screen_size()
    local cx, cy = x * 0.5, y * 0.5
    local daltaWidth, daltaHeight = measure_text("C+","⮞")
    -- AA
    if(isFacingRight)then
        renderer_text(cx  + 75 - daltaWidth, cy - daltaHeight, 0, 255, 251, 255, "C+", 0, "⮞")
        renderer_text(cx  - 55, cy - daltaHeight, 192,192,192,255, "C+", 0, "⮜")
    elseif(isFacingLeft)then
        renderer_text(cx  + 55 - daltaWidth, cy- daltaHeight, 192,192,192,255, "C+", 0, "⮞")
        renderer_text(cx  - 75, cy - daltaHeight, 0, 255, 251, 255, "C+", 0, "⮜")
    else
        renderer_text(cx  - 55, cy- daltaHeight, 192,192,192,255, "C+", 0, "⮜")
        renderer_text(cx  + 55 - daltaWidth, cy- daltaHeight, 192,192,192,255, "C+", 0, "⮞")
    end

    local textBase = ""
    local textBaseFlag = "c-b"
    renderer_text(cx, cy + 30, drawerHelper.randomColor.getR(),drawerHelper.randomColor.getG(),drawerHelper.randomColor.getB(),255, textBaseFlag, 0, textBase)
end

client.set_event_callback("paint", onPaint)

--local TickDelay = globals.tickcount()
--client.set_event_callback("setup_command", function(cmd)
--if TickDelay < globals.tickcount() then
--    cmd.allow_send_packet = true
--    TickDelay = globals.tickcount() + 11 --Choose your fakelag so 5 if you always want 5 fakelag etc
--  else
--    cmd.allow_send_packet = false
--  end
--end)

---@Suppress("Unchecked")
---@Suppress("Unchecked")

local unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}

unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}

unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}

unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}
unused0 = {
    ["Standing"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = -20,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Off",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 50,
    },
    ["Moving"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -15,
        ["jitter"] = "Random",
        ["jitterValue"] = 3,
        ["bodyYaw"] = "Opposite",
        ["bodyYawValue"] = 0,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["Crouching"] = {
        ["pitch"] = "Minimal",
        ["yaw"] = "180",
        ["yawValue"] = -10,
        ["jitter"] = "Random",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["InAir"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180 Z",
        ["yawValue"] = 0,
        ["jitter"] = "Random",
        ["jitterValue"] = 12,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Eye yaw",
        ["limit"] = 60,
    },
    ["SlowMotion"] = {
        ["pitch"] = "Down",
        ["yaw"] = "180",
        ["yawValue"] = 8,
        ["jitter"] = "Off",
        ["jitterValue"] = 0,
        ["bodyYaw"] = "Static",
        ["bodyYawValue"] = -180,
        ["lbyTarget"] = "Opposite",
        ["limit"] = 60,
    },
}





math.randomseed(time())

