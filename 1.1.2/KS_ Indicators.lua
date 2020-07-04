---
--- Title: Indicators
--- Author: april#0001
--- Description: Better indicators
---

--region main

local color_indexes = {"r", "g", "b", "a"};

--endregion

--region menu

local enable = ui.new_checkbox("Misc", "Movement", "Infinite duck fix")

local dormant_text = ui.new_label("VISUALS", "Effects", "mant color");
local dormant = ui.new_color_picker("VISUALS", "Effects", "mant color", 225, 190, 240, 230);
local active_text = ui.new_label("VISUALS", "Effects", "Active color");
local active = ui.new_color_picker("VISUALS", "Effects", "Active color", 0, 255, 251, 255);

--endregion

--region dependencies

local function clamp(v, min, max)
    return math.max(math.min(v, max), min)
end

--region depencendy: noble_color

---@class col_t
local col_t = {};
local col_t_mt = {
    __index = col_t,
    __eq = function(col1, col2)
        return (col1.r == col2.r) and (col1.g == col2.g) and (col1.b == col2.b) and (col1.a == col2.a);
    end
}

--- Creates a new color instance
--- @param r number
--- @param g number
--- @param b number
--- @param a number
--- @return table
function col_t.new(r, g, b, a)

    r = r or 255;
    g = g or 255;
    b = b or 255;
    a = a or 255;

    local props = {
        r = r,
        g = g,
        b = b,
        a = a,

        anim = {
            status = false,
            time = 0
        }
    };

    local meta = setmetatable(props, col_t_mt);

    return meta;
end

--- Unpacks our color into an table
--- @return table
function col_t:unpack()
    return {self.r, self.g, self.b, self.a};
end

--- Updates the color values of a color instance
--- @param color string
--- @param value number
function col_t:update(color, value)
    self[color] = value;
end

--- Setups a color to be animated
--- @param status boolean
--- @param duration number
function col_t:setup_animation(status, duration)
    self.anim.time = duration;
    self.anim.status = status;
end

function col_t:breathe()

    -- Gets our increments based on the animation time
    local increment = ((1 / self.anim.time) * globals.frametime()) * 255

    if (self.a ~= 0 and not self.anim.status) then
        self:update("a", clamp(self.a - increment, 0, 255))
    end

    if (self.a ~= 255 and self.anim.status) then
        self:update("a", clamp(self.a + increment, 0, 255))
    end

    if (self.a == 0) then
        self.anim.status = true
    end

    if (self.a == 255) then
        self.anim.status = false
    end

end

function col_t:shift(initial, final)
    -- Gets our increments based on the animation time
    local increment = ((1 / self.anim.time) * globals.frametime()) * 255;

    local desired = self.anim.status and final or initial;

    if (self == desired) then
        return
    end

    for i=1, #color_indexes do
        local current = color_indexes[i];

        if (self[current] > desired[current]) then
            self[current] = clamp(self[current] - increment, desired[current], 255);
        end

        if (self[current] < desired[current]) then
            self[current] = clamp(self[current] + increment, 0, desired[current]);
        end
    end

end

--endregion

--region functions

local indicators = {};

local colors = {
    doubletap = col_t.new(225, 0, 50, 255),
    onshot = col_t.new(ui.get(dormant)),
    safe = col_t.new(0, 255, 251, 255),
    duck = col_t.new(0, 255, 251, 255),
    GAMESENSE = col_t.new(130, 250, 255, 255)
--125, 220, 238, 200),
};

local dt, dt_key = ui.reference("RAGE", "Other", "Double tap");
local sp = ui.reference("RAGE", "Aimbot", "Force safe point");
local os, os_key = ui.reference("AA", "Other", "On shot anti-aim");
local duck = ui.reference("RAGE", "Other", "Duck peek assist");

function indicators.update_colors()
    -- Get our main colors
    local dormant = col_t.new(ui.get(dormant));
    local active = col_t.new(ui.get(active));

    -- Double tap color
    colors.doubletap:setup_animation(
            ui.get(dt_key) and ui.get(dt),
            0.35
    )

    -- GAMESENSE color
    colors.GAMESENSE:setup_animation(
        colors.GAMESENSE.anim.status,
        1.5
    )

    -- On shot anti-aim color
    colors.onshot:setup_animation(
            ui.get(os_key) and ui.get(os),
            1.5
    )

    -- Safe point color
    colors.safe:setup_animation(
            ui.get(sp),
            1.5
    )

    colors.duck:setup_animation(
            colors.duck.anim.status,
            1.5
    )

    -- Animate double tap
    colors.doubletap:shift(
            col_t.new(225, 190, 240, 230),
            col_t.new(0, 255, 251, 255)
    );

    -- Animate on shot anti-aim
    colors.onshot:shift(dormant, active);

    -- Animate safe point
    colors.safe:shift(dormant, active);

    -- Animate GAMESENSE
    colors.GAMESENSE:breathe();

    -- Animate fake duck
    colors.duck:breathe();
end

function indicators.draw()

    local x, y = client.screen_size();

    renderer.text(
            x / 2,
            y - 500,
            colors.GAMESENSE.r,
            colors.GAMESENSE.g,
            colors.GAMESENSE.b,
            colors.GAMESENSE.a,
            "cb",
            0,
            "B E S T - [ K I M ]"
    );

    renderer.text(
            x / 2,
            y - 486,
            colors.doubletap.r,
            colors.doubletap.g,
            colors.doubletap.b,
            colors.doubletap.a,
            "cb",
            0,
            "DT"
    );

    renderer.text(
            x / 2,
            y - 472,
            colors.onshot.r,
            colors.onshot.g,
            colors.onshot.b,
            colors.onshot.a,
            "cb",
            0,
            "On Shot"
    );

    if (ui.get(sp)) then
        renderer.text(
                x / 2,
                y - 456,
                colors.safe.r,
                colors.safe.g,
                colors.safe.b,
                colors.safe.a,
                "cb",
                0,
                "Safe Point"
        );
    end

    if (ui.get(duck)) then
        renderer.text(
                x / 2,
                y - 440,
                colors.duck.r,
                colors.duck.g,
                colors.duck.b,
                colors.duck.a,
                "cb",
                0,
                "DUCK"
        );
    end

end

local function handle_visibility()
    local enabled = ui.get(enable);

    ui.set_visible(dormant_text, enabled)
    ui.set_visible(dormant, enabled)
    ui.set_visible(active_text, enabled)
    ui.set_visible(active, enabled)
end

handle_visibility();
--endregion

client.set_event_callback("paint", function()

    handle_visibility();

    if (not ui.get(enable)) then
        return
    end

    indicators.update_colors();
    indicators.draw();

end
)

--endregion

local ui_get, client_set_event_callback = ui.get, client.set_event_callback
local enabled = ui.new_checkbox("VISUALS", "Effects", "Thanos snap")
cvar.cl_ragdoll_physics_enable = cvar["cl_ragdoll_physics_enable"]

client_set_event_callback("paint", function()
    local value = ui_get(enabled) and 0 or 1
    if cvar.cl_ragdoll_physics_enable:get_int() ~= value then
        cvar.cl_ragdoll_physics_enable:set_int(value)
    end
end)