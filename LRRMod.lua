if not LRRmod then LRRmod = {} end

LRRmod_config = SMODS.current_mod.config

SMODS.current_mod.optional_features = {
    retrigger_joker = true,
    post_trigger = true
}

assert(SMODS.load_file("globals.lua"))()

SMODS.ObjectType({
	key = "LRRmodAddition",
	default = "j_joker",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

-- Jokers
local joker_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "jokers")
for _, file in ipairs(joker_src) do
    assert(SMODS.load_file("jokers/" .. file))()
end

-- Seals
local seals_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "seals")
for _, file in ipairs(seals_src) do
    assert(SMODS.load_file("seals/" .. file))()
end

-- Consumable
local con_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "consumable")
for _, file in ipairs(con_src) do
    assert(SMODS.load_file("consumable/" .. file))()
end

-- Boosters
local boo_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "boosters")
for _, file in ipairs(boo_src) do
    assert(SMODS.load_file("boosters/" .. file))()
end

-- Enhancements
local enh_src = NFS.getDirectoryItems(SMODS.current_mod.path .. "enhancements")
for _, file in ipairs(enh_src) do
    assert(SMODS.load_file("enhancements/" .. file))()
end