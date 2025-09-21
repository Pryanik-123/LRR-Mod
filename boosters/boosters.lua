SMODS.Atlas{
    key = 'booster_lrr1',
    path = 'booster1.png',
    px = 71,
    py = 96,
}
SMODS.Booster{
    key = 'booster_lrr1',
    group_key = "k_lrr_boosters",
    atlas = 'booster_lrr1', 
    pos = { x = 0, y = 0 },
    discovered = false,
    loc_txt= {
        name = 'Player Pack',
        text = { "Choose {C:attention}#1#{} of up to",
                "{C:attention}#2#{} LRR Mod Joker cards!", }
    },
    
    draw_hand = false,
    config = {
        extra = 2,
        choose = 1, 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 0.375,
    cost = 4,
    kind = "LrrPack",
    
    create_card = function(self, card, i)
        return SMODS.create_card({
            set = "LRRmodAddition",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = false,
        })
    end,
    select_card = 'jokers',

    in_pool = function() return true end
}

SMODS.Atlas{
    key = 'booster_lrr2',
    path = 'booster2.png',
    px = 71,
    py = 96,
}
SMODS.Booster{
    key = 'booster_lrr2',
    group_key = "k_lrr_boosters",
    atlas = 'booster_lrr2', 
    pos = { x = 0, y = 0 },
    discovered = false,
    loc_txt= {
        name = 'Player Pack+',
        text = { "Choose {C:attention}#1#{} of up to",
                "{C:attention}#2#{} LRR Mod Joker cards!", }
    },
    
    draw_hand = false,
    config = {
        extra = 4,
        choose = 1, 
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,

    weight = 0.375,
    cost = 6,
    kind = "LrrPack",
    
    create_card = function(self, card, i)
        return SMODS.create_card({
            set = "LRRmodAddition",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = false,
        })
    end,
    select_card = 'jokers',

    in_pool = function() return true end
}