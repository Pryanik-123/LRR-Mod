SMODS.Atlas {
    key = "plus_seal",
    path = "LRRplusseal.png",
    px = 71,
    py = 96
}

SMODS.Seal {
    name = "plus_seal",
    key = "plus_seal",
    badge_colour = HEX("00ccff"),
	config = { mult = 1, chips = 5, current_mult = 1, current_chips = 10  },
    loc_txt = {
        label = 'LRR+ Seal',
        name = 'LRR+ Seal',
        text = {
            '{C:red}+#1#{} Mult and {C:chips}+#2#{} Chips for',
            'everytime a {C:green}LRR+ Seal{} {C:attention}scored{}',
            'resets after scoring',
            "{C:inactive}(Starts with {C:red}+#3#{} {C:inactive}Mult and {C:chips}+#4#{} {C:inactive}Chips){}"
        }
    },


    loc_vars = function(self, info_queue)
        return { vars = {self.config.mult, self.config.chips, self.config.current_mult, self.config.current_chips } }
    end,
    atlas = "plus_seal",
    pos = {x=0, y=0},

    calculate = function(self, card, context)
        if context.before or context.after then
            self.config.current_mult = 1
            self.config.current_chips = 10
        end
        if context.main_scoring and context.cardarea == G.play then
            self.config.current_mult = self.config.current_mult + self.config.mult
            self.config.current_chips = self.config.current_chips + self.config.chips
            return {
                mult = self.config.current_mult,
                chips = self.config.current_chips,
            }
        end
    end,
}

SMODS.Atlas {
    key = "ulrr_seal",
    path = "ulrrseal.png",
    px = 71,
    py = 96
}

SMODS.Seal {
    name = "ulrr_seal",
    key = "ulrr_seal",
    badge_colour = HEX("ff0000"),
	config = { dollars = 1, x_chips = 1.1, x_mult = 1.1  },
    loc_txt = {
        label = 'ULRR Seal',
        name = 'ULRR Seal',
        text = {
            '{C:money}$#1#{} Moners',
            '{X:chips,C:white}X#2#{} Chips',
            '{X:mult,C:white}X#3#{} Mult'
        }
    },


    loc_vars = function(self, info_queue)
        return { vars = {self.config.dollars, self.config.x_chips, self.config.x_mult } }
    end,
    atlas = "ulrr_seal",
    pos = {x=0, y=0},

    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                dollars = self.config.dollars,
                chips = self.config.chips,
                mult = self.config.mult,
                x_chips = self.config.x_chips,
                x_mult = self.config.x_mult
            }
        end
    end,
}

SMODS.Atlas {
    key = "hrr_seal",
    path = "HRRseal.png",
    px = 71,
    py = 96
}

SMODS.Seal {
    name = "hrr_seal",
    key = "hrr_seal",
    badge_colour = HEX("e8ac42"),
	config = { x_mult = 2 , dollars = 3 },
    loc_txt = {
        label = 'HRR Seal',
        name = 'HRR Seal',
        text = {
            '{X:mult,C:white}X#1#{} Mult',
            'Lose {C:money}$3{}'
        }
    },


    loc_vars = function(self, info_queue)
        return { vars = {self.config.x_mult, self.config.dollars } }
    end,
    atlas = "hrr_seal",
    pos = {x=0, y=0},

    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                x_mult = self.config.x_mult,
                dollars = -self.config.dollars
            }
        end
    end,
}