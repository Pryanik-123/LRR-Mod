SMODS.Atlas {
    key = "lrr_card",
    path = "LRRcard.png",
    px = 71,
    py = 96
}

SMODS.Enhancement {
    key = 'lrr_card',
    pos = {x = 0, y = 0}, 
    atlas = 'lrr_card', 
    config = { extra = { x_chips = 1.5 } },
    loc_txt= {
        name = 'LRR Card',
        text = { "{X:chips,C:white}X#1#{} Chips",
                 "while this card",
                 "stays in hand" }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_chips } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.hand then
            return {
                x_chips = card.ability.extra.x_chips,
                card = card
            }
        end
    end
}