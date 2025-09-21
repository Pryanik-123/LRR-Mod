SMODS.Sound({key = "bwomp", path = "Bwomp.ogg"})
SMODS.Atlas{
    key = 'stats_viewer',
    path = 'Stats_viewer.png',
    px = 71,
    py = 96
}
SMODS.Consumable({
    key = "stats_viewer",
    set = "Tarot",
    object_type = "Consumable",
    name = "stats_viewer",
    loc_txt = {
        name = "Stats Viewer",
        text={
        "Creates a random",
        "{C:attention}LRR Mod Joker{}",
        "{C:inactive}(must have room){}",
        },
    },
	
	
	pos = {x=0, y=0},
	atlas = "stats_viewer",
    unlocked = true,
    discovered = false,
    cost = 5,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('lrr_bwomp')
                local card = create_card("LRRmodAddition", G.jokers, nil, nil, nil, nil, nil, 'stats_viewer')
                card:add_to_deck()
                G.jokers:emplace(card)
                return true end }))
            delay(0.6)
    end,

    can_use = function(self, card)
        if #G.jokers.cards < G.jokers.config.card_limit then
            return true
        end
	end
})

SMODS.Atlas{
    key = 'computer',
    path = 'Computer.png',
    px = 71,
    py = 96
}
SMODS.Consumable({
    key = "computer",
    set = "Spectral",
    object_type = "Consumable",
    name = "Mom's Old Computer",
    loc_txt = {
        name = "Mom's Old Computer",
        text={
        "Add a {C:red}ULRR Seal{}",
        "to {C:attention}1{} selected",
        "card in your hand"
        },
    },
    config = {
        max_highlighted = 1,
        extra = 'ulrr_seal',
    },
	
	
	pos = {x=0, y=0},
	atlas = "computer",
    unlocked = true,
    discovered = false,
    cost = 6,

    use = function(self, card, area, copier)
        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true end }))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[i].seal = "lrr_ulrr_seal"
                return true end }))
            
            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end,
})

SMODS.Atlas{
    key = 'cbf',
    path = 'Cbf.png',
    px = 71,
    py = 96
}
SMODS.Consumable({
    key = "cbf",
    set = "Spectral",
    object_type = "Consumable",
    name = "Click Between Frames",
    loc_txt = {
        name = "Click Between Frames",
        text={
        "Add a {C:red}HRR Seal{}",
        "to {C:attention}1{} selected",
        "card in your hand"
        },
    },
    config = {
        max_highlighted = 1,
        extra = 'hrr_seal',
    },
	
	
	pos = {x=0, y=0},
	atlas = "cbf",
    unlocked = true,
    discovered = false,
    cost = 6,

    use = function(self, card, area, copier)
        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true end }))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[i].seal = "lrr_hrr_seal"
                return true end }))
            
            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end,
})

SMODS.Atlas{
    key = 'monitor',
    path = 'Monitor.png',
    px = 71,
    py = 96
}
SMODS.Consumable({
    key = "monitor",
    set = "Spectral",
    object_type = "Consumable",
    name = "Stolen monitor",
    loc_txt = {
        name = "Stolen monitor",
        text={
        "Add a {C:green}LRR+ Seal{}",
        "to {C:attention}1{} selected",
        "card in your hand"
        },
    },
    config = {
        max_highlighted = 1,
        extra = 'plus_seal',
    },
	
	
	pos = {x=0, y=0},
	atlas = "monitor",
    unlocked = true,
    discovered = false,
    cost = 6,

    use = function(self, card, area, copier)
        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true end }))
            
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.hand.highlighted[i].seal = "lrr_plus_seal"
                return true end }))
            
            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    end,
})

SMODS.Atlas{
    key = 'lrr',
    path = 'Handicap.png',
    px = 71,
    py = 96
}
SMODS.Consumable({
    key = "lrr",
    set = "Tarot",
    object_type = "Consumable",
    name = "The Handicap",
    loc_txt = {
        name = "The Handicap",
        text={
        "Enhances {C:attention}1{} selected",
        "card into a",
        "{C:attention}LRR Card"
        },
    },
    config = {
        max_highlighted = 1,
        extra = 'lrr_card',
    },
	
	
	pos = {x=0, y=0},
	atlas = "lrr",
    unlocked = true,
    discovered = false,
    cost = 3,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
		return true end }))
		delay(0.2)
		for i, v in pairs(G.hand.highlighted) do
			local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() v:flip();play_sound('card1', percent, 1);v:juice_up(0.3, 0.3);return true end }))
			G.E_MANAGER:add_event(Event({trigger = 'after',func = function() v:set_ability(G.P_CENTERS["m_lrr_card"]);return true end }))
			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() v:flip();play_sound('tarot2', percent, 0.6);v:juice_up(0.3, 0.3);return true end }))
		end
		delay(0.2)
		G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
	end,

    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_lrr_card

		return { vars = { card and card.ability.max_highlighted or self.config.max_highlighted } }
	end,
})