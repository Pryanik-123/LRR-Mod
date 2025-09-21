--- GLOBALS

G.C.PM = {
    RED = HEX("FF0000"),
    ORANGE = HEX("ff8d29"),
    BLACK = HEX("000000"),
    BLUE = HEX("0000FF"),
    GREEN = HEX("00FF00"),
    WHITE = HEX("FFFFFF"),
    TRANSPARENT = HEX("00000000"),
}

-- Hooks

local loc_colour_ref = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        loc_colour_ref()
    end
    G.ARGS.LOC_COLOURS.pm_red = G.C.PM.RED
    G.ARGS.LOC_COLOURS.pm_black = G.C.PM.BLACK
    G.ARGS.LOC_COLOURS.pm_blue = G.C.PM.BLUE
    G.ARGS.LOC_COLOURS.pm_green = G.C.PM.GREEN
    G.ARGS.LOC_COLOURS.pm_white = G.C.PM.WHITE
    G.ARGS.LOC_COLOURS.pm_transparent = G.C.PM.TRANSPARENT
    return loc_colour_ref(_c, _default)
end