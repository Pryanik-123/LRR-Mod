
-- you can have shared helper functions
function shakecard(self) --visually shake a card
    G.E_MANAGER:add_event(Event({
        func = function()
            self:juice_up(0.5, 0.5)
            return true
        end
    }))
end

SMODS.Atlas({
    key = "tipito",
    path = "j_tipito.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "tipito",                                  
    config = { extra = {} },                
    pos = { x = 0, y = 0 },    
    pools = {["LRRmodAddition"] = true},                     
    rarity = 1,                                        
    cost = 4,                                        
    blueprint_compat=true,                             
    eternal_compat=true,   
    perishable_compat = true,                        
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'tipito',                                

    calculate = function(self,card,context)
        if context.joker_main and context.cardarea == G.jokers then
            local three = false
            local six = false
            for i = 1, #context.scoring_hand do
				if context.full_hand[i]:get_id() == 6 then
                    six = true
                end
                if context.full_hand[i]:get_id() == 3 then
                    three = true
                end
            end

            if three or six then
                G.GAME.blind.chips = math.floor(G.GAME.blind.chips * 0.9)
                G.GAME.blind.chip_text = G.GAME.blind.chips
                return{
                    extra = { focus = card, message = "All y'all high refresh players who think Sonic Wave is easier then Erebus, first of all shut the fuck up and 2nd of all of the wave plays by itself for you guys."}
                }
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end
}

SMODS.Atlas({
    key = "hpsk",
    path = "j_hpsk.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "hpsk",                                  
    config = { extra = {x_chips = 1.25, chance = 6, message = "Site is ok", color = G.C.GREEN } },                
    pos = { x = 0, y = 0 },              
    pools = {["LRRmodAddition"] = true},           
    rarity = 3,                                        
    cost = 7,                                        
    blueprint_compat=true,                             
    eternal_compat=true,               
    perishable_compat = true,            
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'hpsk',                                

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            return{
                x_chips = card.ability.extra.x_chips,
                card = card
            }
        end
        if context.destroying_card and (not context.blueprint) then
            for k, v in ipairs(context.scoring_hand) do
                if pseudorandom('hpsk') < G.GAME.probabilities.normal/card.ability.extra.chance then
                    card.ability.extra.message = 'Site crashed'
                    card.ability.extra.color = G.C.RED
                    return not SMODS.is_eternal(context.destroying_card)
                end
            end
        end
        if context.before and (not context.blueprint) then
            card.ability.extra.message = 'Site is ok'
            card.ability.extra.color = G.C.GREEN
        end
        if context.after and (not context.blueprint) then
            return{
                message = card.ability.extra.message,
                colour = card.ability.extra.color,
                card = card
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_chips, (G.GAME.probabilities.normal or 1)} }
    end
}

SMODS.Atlas({
    key = "dominionxx",
    path = "j_dominionxx.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "dominionxx",                                  
    config = { extra = { x_mult = 1, x_mult_mod = 0.5 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 8,                                        
    blueprint_compat=true,                             
    eternal_compat=true,
    perishable_compat = true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'dominionxx',                                

    calculate = function(self,card,context)
        if G.playing_cards and (not context.blueprint) then
            card.ability.extra.x_mult = 1 + math.floor(#G.playing_cards / 12) * card.ability.extra.x_mult_mod
        end
        if context.joker_main and context.cardarea == G.jokers then
            return {
                x_mult = card.ability.extra.x_mult,
                card = card,
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult } }
    end
}

SMODS.Atlas({
    key = "nejus",
    path = "j_nejus.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "nejus",                                  
    config = { extra = {} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 4,                                        
    blueprint_compat=true,                             
    eternal_compat=true,
    perishable_compat = true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'nejus',                                

    calculate = function(self,card,context)
        if context.cardarea == G.jokers then
            if context.before then
                if context.scoring_name == 'Flush' or context.scoring_name == 'Straight Flush' or context.scoring_name == 'Flush House' or context.scoring_name == 'Flush Five' and (not context.blueprint) then
                    local cards = {}
                    for k, v in ipairs(context.scoring_hand) do
                        if not v:is_suit('Spades') then 
                            cards[#cards+1] = v
                            v:change_suit('Spades')
                            if v.ability.name == 'Default Base' then
                                v:set_ability(G.P_CENTERS.m_mult)
                            end
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    v:juice_up()
                                    return true
                                end
                            })) 
                        else 
                            cards[#cards+1] = v
                            if v.ability.name == 'Default Base' then
                                v:set_ability(G.P_CENTERS.m_mult)
                            end
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    v:juice_up()
                                    return true
                                end
                            }))
                        end
                    end
                    if #cards > 0 then 
                        return {
                            message = "Monkey'd",
                            colour = G.C.BLACK,
                            card = card
                        }
                    end
                end
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
        return { vars = {} }
    end
}

SMODS.Atlas({
    key = "shrek",
    path = "j_shrek.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "shrek",                                  
    config = { extra = { x_mult = 1} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 7,                                        
    blueprint_compat=true,                             
    eternal_compat=true,
    perishable_compat = true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'shrek',                                

    calculate = function(self,card,context)
        if context.remove_playing_cards and (not context.blueprint) then
            local spades = 0;
            for k, v in ipairs(context.removed) do
                if v:is_suit("Spades") then spades = spades + 1 end
            end
            if spades > 0 then
                card.ability.extra.x_mult = card.ability.extra.x_mult + spades * 0.25
                 G.E_MANAGER:add_event(Event({
                    func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.x_mult}}}); return true
                    end}))
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return {
                x_mult = card.ability.extra.x_mult,
                card = card,
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult}  }
    end
}

SMODS.Atlas({
    key = "hombie",
    path = "j_hombie.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "hombie",                                  
    config = { extra = { mult = 0 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 4,                                        
    blueprint_compat=true,                             
    eternal_compat=true,
    perishable_compat = true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'hombie',                                

    calculate = function(self,card,context)
        if context.discard and context.other_card:get_id() == 12 and (not context.blueprint) then
            if not context.other_card.debuff then
                card.ability.extra.mult = card.ability.extra.mult + 2
                return {
                    message = 'Bye Bye Queen',
                    card = card,
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main and context.cardarea == G.jokers and (card.ability.extra.mult > 0) then
            return{
                mult = card.ability.extra.mult,
                card = card,
                colour = G.C.MULT
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end
}

SMODS.Atlas({
    key = "theo",
    path = "j_theonec.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "theo",                                  
    config = { extra = {} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 6,                                        
    blueprint_compat=false,                             
    eternal_compat=false,
    perishable_compat = false,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'theo',                                

    calculate = function(self,card,context)
        if context.selling_self and (not context.blueprint) then
            local seals = {'Red', 'Blue', 'Gold', 'Purple', 'lrr_plus_seal', 'lrr_ulrr_seal', 'lrr_hrr_seal'}
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].seal == nil then
                    G.hand.cards[i].seal = seals[math.random(1,6)]
                end
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end
}

SMODS.Atlas({
    key = "pigeons",
    path = "j_pigeons.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "pigeons",                                  
    config = { },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 9,                                        
    blueprint_compat=true,                             
    eternal_compat=true,
    perishable_compat = true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'pigeons',                                

    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card.seal == "lrr_ulrr_seal" then 
                    return {
                        message = localize("k_again_ex"),
                        repetitions = 1,
                        card = card,
                    }
            end
        end

        if context.cardarea == G.jokers then
            if context.before then
                if #G.play.cards == 1 and G.GAME.current_round.hands_played == 0 and (not context.blueprint) then
                    for k, v in ipairs(context.scoring_hand) do
                        v.seal = "lrr_ulrr_seal"
                    end
                    return{
                        message = 'I cast degeneracy upon ye',
                        colour = G.C.PM.PURPLE
                    }
                end
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return {  }
    end
}

SMODS.Atlas({
    key = "iconic",
    path = "j_iconic.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "iconic",                                  
    config = {},                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 5,                                        
    blueprint_compat=true,                             
    eternal_compat=true,
    perishable_compat = true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'iconic',                                

    calculate = function(self,card,context)
        if context.end_of_round and not (context.blueprint_card or card).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < 2 then
            if G.ARGS.chip_flames.real_intensity > 0.000001 then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                local carde = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'car')
                                carde:add_to_deck()
                                G.consumeables:emplace(carde)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end}))   
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})                       
                        return true
                    end)}))
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                    func = (function()
                        G.E_MANAGER:add_event(Event({
                            func = function() 
                                local carde = create_card('Planet',G.consumeables, nil, nil, nil, nil, nil, 'car')
                                carde:add_to_deck()
                                G.consumeables:emplace(carde)
                                G.GAME.consumeable_buffer = 0
                                return true
                            end}))   
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.BLUE})                       
                        return true
                    end)}))
                end
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { }
    end
}

SMODS.Sound({key = "bsod", path = "BSOD.ogg"})
SMODS.Atlas({
    key = "samamba",
    path = "j_samamba.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "samamba",                                  
    config = { extra = { x_mult = 2, x_chips = 2, chance = 8} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 6,                                        
    blueprint_compat=true,                             
    eternal_compat=false, 
    perishable_compat = true,                          
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'samamba',                                

    calculate = function(self,card,context)
        if context.before and (not context.blueprint) then
            if pseudorandom('samamba') < G.GAME.probabilities.normal/card.ability.extra.chance then
                showCrash()
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return{
                x_mult = card.ability.extra.x_mult,
                x_chips = card.ability.extra.x_chips,
                card = card
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult, card.ability.extra.x_chips, (G.GAME.probabilities.normal or 1)} }
    end
}

SMODS.Atlas({
    key = "pryanik",
    path = "j_pryanik.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "pryanik",                                  
    config = { extra = { chance = 5, chance2 = 10 }},                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 10,                                        
    blueprint_compat=true,                             
    eternal_compat=true,
    perishable_compat = true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'pryanik',                                

    calculate = function(self,card,context)
        if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
            if context.other_card.edition and context.other_card.edition.type == "negative" then
                local amount = 1
                if pseudorandom('pryanik') < G.GAME.probabilities.normal/card.ability.extra.chance then
                    amount = amount + 1
                end
                if pseudorandom('pryanik') < G.GAME.probabilities.normal/card.ability.extra.chance2 then
                    amount = amount + 1
                end
                return {
                    extra = { focus = card, message = localize('k_again_ex')},
                    repetitions = amount,
                    card = card
                }
            else
                return nil, true end
		end
    end;

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return { vars = {(G.GAME.probabilities.normal or 1)} }
    end
}

SMODS.Atlas({
    key = "biprex",
    path = "j_biprex.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "biprex",                                  
    config = { extra = { chips = 1395 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 20,                                        
    blueprint_compat=true,                             
    eternal_compat=true,
    perishable_compat = true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'biprex',                                

    calculate = function(self,card,context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                chips = card.ability.extra.chips,
                card = card,
                colour = G.C.CHIPS
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.chips} }
    end
}

SMODS.Atlas({
    key = "tactical",
    path = "j_tactical.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "tactical",                                  
    config = { extra = {payout = 10}},                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 7,                                        
    blueprint_compat=false,                             
    eternal_compat=false,
    perishable_compat = false,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'tactical',                                

    calculate = function(self,card,context)
        if context.end_of_round and context.cardarea == G.jokers and (not context.blueprint) then
            if G.GAME.blind.boss then
                if card.ability.extra.payout == 2 then
                    G.E_MANAGER:add_event(Event({
                                func = function()
                                    play_sound('tarot1')
                                    card.T.r = -0.2
                                    card:juice_up(0.3, 0.4)
                                    card.states.drag.is = true
                                    card.children.center.pinch.x = true
                                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                        func = function()
                                                G.jokers:remove_card(card)
                                                card:remove()
                                                card = nil
                                            return true; end})) 
                                    return true
                                end
                            }))
                    return {
                        message = 'Tax Evasion',
                        colour = G.C.MONEY
                    }
                else 
                    card.ability.extra.payout = card.ability.extra.payout - 2
                    return {
                        message = 'Rent is due...',
                        colour = G.C.MONEY
                    }
                end
            end 
        end
    end;

    calc_dollar_bonus = function(self,card)
        return card.ability.extra.payout
    end,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.payout}}
    end
}

SMODS.Atlas({
    key = "truebolt",
    path = "j_truebolt.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "truebolt",                                  
    config = { extra = { x_chips = 1.25 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 6,                                        
    blueprint_compat=true,                             
    eternal_compat=true,
    perishable_compat = true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'truebolt',                                

    calculate = function(self,card,context)
        if not context.end_of_round then
            if context.cardarea == G.hand and context.individual and context.other_card:get_id() == 12 then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = card,
                    }
                else
                    return {
                        x_chips = card.ability.extra.x_chips,
                        card = card
                    }
                end
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_chips} }
    end
}

SMODS.Atlas({
    key = "jollow",
    path = "j_jollow.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "jollow",                                  
    config = { extra = {dollars = 1}},                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 7,                                        
    blueprint_compat=true,                             
    eternal_compat=true,
    perishable_compat = true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'jollow',                                

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.ability.name == 'Default Base' then
                return {
                    dollars = card.ability.extra.dollars,
                    card = card,
                    colour = G.C.MONEY
                }
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.dollars} }
    end
}

SMODS.Atlas({
    key = "cejelost",
    path = "j_cejelost.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "cejelost",                                  
    config = { extra = { mult = 10, chips = 50, dollars = 5, x_mult = 1.2, x_chips = 1.2, chance = 5}},                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 6,                                        
    blueprint_compat=false,                             
    eternal_compat=true,
    perishable_compat = true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'cejelost',                                

    calculate = function(self,card,context)
        if context.joker_main and context.cardarea == G.jokers and (not context.blueprint) then
            local choice = math.random(1,5)
            local effectMult = 1
            if pseudorandom('cejelost') < G.GAME.probabilities.normal/card.ability.extra.chance then
                effectMult = 10
            end

            local cejeMessage
            if effectMult == 10 then
                cejeMessage = "I BEAT NEW TOP 1"
            else cejeMessage = "Getting far..."
            end

            if choice == 1 then
                return{
                    mult = card.ability.extra.mult * effectMult,
                    card = card,
                    extra = { focus = card, message = cejeMessage, colour = G.C.RED}
                }
            end
            if choice == 2 then
                return{
                    chips = card.ability.extra.chips * effectMult,
                    card = card,
                    extra = { focus = card, message = cejeMessage, colour = G.C.RED}
                }
            end
            if choice == 3 then
                return{
                    dollars = card.ability.extra.dollars * effectMult,
                    card = card,
                    extra = { focus = card, message = cejeMessage, colour = G.C.RED}
                }
            end
            if choice == 4 then
                return{
                    x_mult = card.ability.extra.x_mult * effectMult,
                    card = card,
                    extra = { focus = card, message = cejeMessage, colour = G.C.RED}
                }
            end
            if choice == 5 then
                return{
                    x_chips = card.ability.extra.x_chips * effectMult,
                    card = card,
                    extra = { focus = card, message = cejeMessage, colour = G.C.RED}
                }
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.dollars, card.ability.extra.x_mult, card.ability.extra.x_chips, (G.GAME.probabilities.normal or 1)} }
    end
}

SMODS.Atlas({
    key = "typier",
    path = "j_typier.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "typier",                                  
    config = { extra = { x_mult = 1} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 6,                                        
    blueprint_compat=true,                             
    eternal_compat=true,
    perishable_compat = true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'typier',                                

    calculate = function(self,card,context)
        if context.cardarea == G.jokers and context.joker_main then
			return {
				x_mult = card.ability.extra.x_mult
			}
		end
        if context.individual and context.cardarea == G.play and context.other_card.ability.name == 'Lucky Card' and (not context.other_card.lucky_trigger) and (not context.blueprint) then
            card.ability.extra.x_mult = card.ability.extra.x_mult + 0.25
            return {
                extra = { focus = card, message = "Patience...", colour = G.C.Red}
            }
        end
        if context.individual and context.other_card.lucky_trigger and (not context.blueprint) then
            if card.ability.extra.x_mult > 1 then
                if card.ability.extra.x_mult >= 1.75 then card.ability.extra.x_mult = card.ability.extra.x_mult - 0.75
                else card.ability.extra.x_mult = card.ability.extra.x_mult - (card.ability.extra.x_mult - 1) end
            end
            return {
                extra = { focus = card, message = "Karma", colour = G.C.Red}
            }
		end
    end;

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        return { vars = {card.ability.extra.x_mult} }
    end
}

SMODS.Atlas({
    key = "jaynt",
    path = "j_jaynt.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "jaynt",                                  
    config = { extra = { h_size = -3 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 5,                                        
    blueprint_compat=false,                             
    eternal_compat=true,
    perishable_compat = false,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'jaynt',                                

    add_to_deck = function(self, card, from_debuff)
        change_shop_size(5)
        G.hand:change_size(card.ability.extra.h_size)
    end,
    remove_from_deck = function(self, card, from_debuff) 
        change_shop_size(-5)
        G.hand:change_size(-card.ability.extra.h_size)
    end,


    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.h_size} }
    end
}

SMODS.Atlas({
    key = "dangadash",
    path = "j_dangadash.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "dangadash",                                  
    config = { extra = { chips = 0 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 4,                                        
    blueprint_compat=true,                             
    eternal_compat=true,
    perishable_compat = true,                           
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'dangadash',                                

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and (not context.blueprint) then
            if context.other_card:get_id() == 11 then
                card.ability.extra.chips = card.ability.extra.chips + 5
                return {
                    extra = { focus = card, message = "Hey daddy", colour = G.C.CHIPS},
                    card = card
                }
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return{
                chips = card.ability.extra.chips,
                card = card
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end
}

SMODS.Sound({key = "bell", path = "Bell.ogg"})
SMODS.Atlas({
    key = "raptor",
    path = "j_electroraptor.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "raptor",                                  
    config = { extra = { x_mult = 1 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 6,                                        
    blueprint_compat=true,                             
    eternal_compat=true, 
    perishable_compat = true,                          
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'raptor',                                

    calculate = function(self,card,context)
        if context.cardarea == G.jokers and context.joker_main then
			return {
				x_mult = card.ability.extra.x_mult
			}
		end
        if context.after and (not context.blueprint) then
            local glasses = 0
            for k, v in ipairs(context.scoring_hand) do
                if not v.shattered and v.ability.name == "Glass Card" then
                    glasses = 1 
                    card.ability.extra.x_mult = card.ability.extra.x_mult + 0.2
                end
            end
            if glasses == 1 then return {
                extra = { focus = card, message = "Amen", colour = G.C.MULT, sound = 'lrr_bell'}
            }
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { vars = { card.ability.extra.x_mult } }
    end
}

SMODS.Atlas({
    key = "zeralth",
    path = "j_zeralth.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "zeralth",                                  
    config = { extra = { x_mult = 1.9, hasAce, hasNine } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 4,                                        
    blueprint_compat=true,                             
    eternal_compat=true, 
    perishable_compat = true,                          
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'zeralth',                                

    calculate = function(self,card,context)
        if context.before then
            card.ability.extra.hasAce = false 
            card.ability.extra.hasNine = false
        end
        if not context.end_of_round then
            if context.cardarea == G.hand and context.individual then
                if context.other_card:get_id() == 9 then
                    card.ability.extra.hasNine = true
                end
                if context.other_card:get_id() == 14 then
                    card.ability.extra.hasAce = true
                end
            end
        end

        if context.joker_main and context.cardarea == G.jokers then
            if card.ability.extra.hasNine and card.ability.extra.hasAce then
                return{
                    x_mult = card.ability.extra.x_mult,
                    card = card
                }
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult } }
    end
}

SMODS.Atlas({
    key = "lucky",
    path = "j_luckyns.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "lucky",                                  
    config = { },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 8,                                        
    blueprint_compat=true,                             
    eternal_compat=true,        
    perishable_compat = true,                   
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'lucky',                                

    calculate = function(self,card,context)
        if context.repetition then
            if context.cardarea == G.play then
                if context.other_card.ability.name == "Lucky Card" and context.other_card:get_id() == 7 then
                    return{
                        message = 'Lucky Seven!',
                        repetitions = 3,
                        card = card
                    }
                end
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        return { }
    end
}

SMODS.Sound({key = "explosion", path = "Explosion.ogg"})
SMODS.Atlas({
    key = "darkgamma",
    path = "j_darkgamma.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "darkgamma",                                  
    config = { extra = { chips = 200, chance = 6 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 4,                                        
    blueprint_compat=true,                             
    eternal_compat=false,   
    perishable_compat = false,                        
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'darkgamma',                                

    calculate = function(self,card,context)
        if context.end_of_round and context.cardarea == G.jokers and (not context.blueprint) then
            if pseudorandom('darkgamma') < G.GAME.probabilities.normal/card.ability.extra.chance then
                G.E_MANAGER:add_event(Event({
                                func = function()
                                    play_sound('lrr_explosion')
                                    card.T.r = -0.2
                                    card:juice_up(0.3, 0.4)
                                    card.states.drag.is = true
                                    card.children.center.pinch.x = true
                                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                        func = function()
                                                G.jokers:remove_card(card)
                                                card:remove()
                                                card = nil
                                            return true; end})) 
                                    return true
                                end
                            }))
                    return {
                        message = 'Kaboom',
                        colour = G.C.CHIPS
                    }
                else
                    return {
                        message = 'Safe',
                        colour = G.C.CHIPS
                    }
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return{
                chips = card.ability.extra.chips,
                card = card
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, (G.GAME.probabilities.normal or 1) } }
    end
}

SMODS.Atlas({
    key = "donut",
    path = "j_wwdonut.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "donut",                                  
    config = { extra = {current_xmult = 1, xmult = 0.2}},                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 8,                                        
    blueprint_compat=true,                             
    eternal_compat=true,        
    perishable_compat = true,                   
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'donut',                                

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play and (not context.blueprint) then
            card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.xmult 
        end
        if context.joker_main and context.cardarea == G.jokers then
            return{
                x_mult = card.ability.extra.current_xmult,
                card = card
            }
        end
        if context.after then
            card.ability.extra.current_xmult = 1
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.current_xmult, card.ability.extra.xmult } }
    end
}

SMODS.Atlas({
    key = "cedric",
    path = "j_cedric.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "cedric",                                  
    config = { extra = { x_chips = 2} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 4,                                        
    blueprint_compat=true,                             
    eternal_compat=true,        
    perishable_compat = true,                   
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'cedric',                                

    calculate = function(self,card,context)
        if context.joker_main and context.cardarea == G.jokers then
            local sixes = 0
            for i = 1, #context.scoring_hand do
				if context.full_hand[i]:get_id() == 6 then
                    sixes = sixes + 1
                end
            end

            if sixes > 1 then
                return{
                    x_chips = card.ability.extra.x_chips,
                    card = card
                }
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_chips} }
    end
}

SMODS.Atlas({
    key = "wacky",
    path = "j_wacky.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "wacky",                                  
    config = { extra = { chance = 15} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 9,                                        
    blueprint_compat=false,                             
    eternal_compat=true,   
    perishable_compat = true,                        
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'wacky',                                

    calculate = function(self,card,context)
        if context.reroll_shop and (not context.blueprint) then
            local activated = false;
            for i = 1, #G.shop_jokers.cards do
                if pseudorandom('wacky') < G.GAME.probabilities.normal/card.ability.extra.chance and G.shop_jokers.cards[i].ability.set == 'Joker' then
                    G.shop_jokers.cards[i]:set_edition({negative = true}, true)
                    activated = true
                end
            end
            if activated then return{
                    message = 'Focus Pocus',
                    card = card,
                    colour = G.C.BLACK
                }
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return { vars = {(G.GAME.probabilities.normal or 1)}}
    end
}

SMODS.Atlas({
    key = "lobster",
    path = "j_lobster.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "lobster",                                  
    config = { extra = { x_chips = 1.75 } },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 5,                                        
    blueprint_compat=true,                             
    eternal_compat=false,    
    perishable_compat = false,                       
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'lobster',                                

    calculate = function(self,card,context)
        if context.discard and (not context.blueprint) then
            if card.ability.extra.x_chips - 0.01 <= 1 then 
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                func = function()
                                        G.jokers:remove_card(card)
                                        card:remove()
                                        card = nil
                                    return true; end})) 
                            return true
                        end
                    })) 
                    return {
                        message = localize('k_eaten_ex'),
                        colour = G.C.CHIPS
                    }
            else
                    card.ability.extra.x_chips = card.ability.extra.x_chips - 0.01
                    return {
                        delay = 0.2,
                        message = "Nom",
                        colour = G.C.CHIPS
                    }
            end       
        end

        if context.joker_main and context.cardarea == G.jokers then
            return{
                x_chips = card.ability.extra.x_chips,
                card = card
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_chips} }
    end
}

SMODS.Atlas({
    key = "meow",
    path = "j_meow.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "meow",                                  
    config = { extra = { repetitions = 1} },                
    pos = { x = 0, y = 0 },        
    pools = {["LRRmodAddition"] = true},                 
    rarity = 3,                                        
    cost = 8,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                   
    perishable_compat = true,        
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'meow',                                

    calculate = function(self,card,context)
        if context.repetition and context.cardarea == G.play and context.scoring_name == 'Pair' then
            local cards = 0
            for k, v in ipairs(context.scoring_hand) do
                if v.seal == "lrr_plus_seal" then 
                    cards = cards + 1
                end
            end
            if cards == 2 then
                return{
                    message = localize("k_again_ex"),
                    repetitions = card.ability.extra.repetitions,
                    card = card,
                }
            end
        end
        if context.after and (not context.blueprint) then
            local cards = 0
            for k, v in ipairs(context.scoring_hand) do
                if v.seal == "lrr_plus_seal" then 
                    cards = cards + 1
                end
            end
            if cards == 2 then
                card.ability.extra.repetitions = card.ability.extra.repetitions + 1
                return{
                    message = "+1 Repetition",
                    colour = G.C.GREEN,
                    card = card
                }
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.repetitions} }
    end
}

SMODS.Atlas({
    key = "emil",
    path = "j_emil.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "emil",                                  
    config = { extra = { mult = 9.5, chips = 95} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 4,                                        
    blueprint_compat=true,                             
    eternal_compat=true,   
    perishable_compat = true,                        
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'emil',                                

    calculate = function(self,card,context)
        if context.joker_main and context.cardarea == G.jokers then
            return{
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips,
                card = card
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.mult, card.ability.extra.chips } }
    end
}

SMODS.Atlas({
    key = "cooper",
    path = "j_cooper.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "cooper",                                  
    config = { extra = { x_mult = 0.2, current_x_mult = 1} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 7,                                        
    blueprint_compat=true,                             
    eternal_compat=true,   
    perishable_compat = true,                        
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'cooper',                                

    calculate = function(self,card,context)
        if G.playing_cards and (not context.blueprint) then
            for k, v in pairs(G.playing_cards) do
                if v.ability.name == 'm_lrr_card' then card.ability.extra.current_x_mult = 1 + card.ability.extra.x_mult end
            end
        end
        if context.cardarea == G.jokers and context.joker_main then
            return{
                x_mult = card.ability.extra.current_x_mult,
                card = card
            }
        end 
    end;

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lrr_card
        return { vars = {card.ability.extra.x_mult, card.ability.extra.current_x_mult} }
    end
}

SMODS.Atlas({
    key = "swm",
    path = "j_swm.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "swm",                                  
    config = { extra = { x_mult = 0.25, current_x_mult = 1} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 7,                                        
    blueprint_compat=true,                             
    eternal_compat=true, 
    perishable_compat = true,                          
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'swm',                                

    calculate = function(self,card,context)
        if (not context.blueprint) then
            card.ability.extra.current_x_mult = 1 + (card.ability.extra.x_mult * G.GAME.round_resets.blind_ante)
        end
        if context.cardarea == G.jokers and context.joker_main then
            return{
                x_mult = card.ability.extra.current_x_mult,
                card = card
            }
        end 
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.current_x_mult } }
    end
}

SMODS.Atlas({
    key = "vipervenom",
    path = "j_vipervenom.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "vipervenom",                                  
    config = { extra = { dollars = 5} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 6,                                        
    blueprint_compat=true,                             
    eternal_compat=true,              
    perishable_compat = true,             
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'vipervenom',                                

    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.seal == "lrr_hrr_seal" then
                return{
                    dollars = card.ability.extra.dollars,
                    card = card
                }
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars} }
    end
}

SMODS.Atlas({
    key = "emerald",
    path = "j_emerald.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "emerald",                                  
    config = { extra = { spectral_x_mult = 0.15, tarot_x_mult = 0.1, current_xmult = 1} },                
    pos = { x = 0, y = 0 },       
    pools = {["LRRmodAddition"] = true},                     
    rarity = 2,                                        
    cost = 6,                                        
    blueprint_compat=true,                             
    eternal_compat=true,             
    perishable_compat = true,              
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'emerald',                                

    calculate = function(self,card,context)
        if context.using_consumeable then
            if context.consumeable.ability.set == "Spectral" and (not context.blueprint) then
                card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.spectral_x_mult
                return {
                    extra = { focus = card, message = 'Yum!', colour = G.C.PM.BLUE},
                }
            end
            if context.consumeable.ability.set == "Tarot" and (not context.blueprint) then
                card.ability.extra.current_xmult = card.ability.extra.current_xmult + card.ability.extra.tarot_x_mult
                return {
                    extra = { focus = card, message = 'Yum!', colour = G.C.PM.ORANGE},
                }
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            return{
                x_mult = card.ability.extra.current_xmult,
                card = card,
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.spectral_x_mult, card.ability.extra.tarot_x_mult, card.ability.extra.current_xmult } }
    end
}


SMODS.Atlas({
    key = "derpy",
    path = "j_derpy.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "derpy",                                  
    config = { extra = {} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 6,                                        
    blueprint_compat=true,                             
    eternal_compat=true,   
    perishable_compat = true,                        
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'derpy',                                

    calculate = function(self,card,context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if G.GAME.blind:get_type() ~= 'Boss' then
                local card = create_card(nil, G.consumeables, nil, nil, nil, nil, 'c_lrr_lrr', 'derpy')
                card:add_to_deck()
                G.consumeables:emplace(card)
                active = false
                return{message = ":p"}
            else
                local randomize = math.random(1,3)
                local card
                if randomize == 1 then
                    card = create_card(nil, G.consumeables, nil, nil, nil, nil, 'c_lrr_monitor', 'derpy')
                elseif randomize == 2 then
                    card = create_card(nil, G.consumeables, nil, nil, nil, nil, 'c_lrr_computer', 'derpy')
                elseif randomize == 3 then
                    card = create_card(nil, G.consumeables, nil, nil, nil, nil, 'c_lrr_cbf', 'derpy')
                end
                card:add_to_deck()
                G.consumeables:emplace(card)
                active = false
                return{message = ":p"}
            end
            
        end
    end;

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_lrr_lrr
        return { vars = {} }
    end
}

SMODS.Atlas({
    key = "ryan",
    path = "j_ryan.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "ryan",                                  
    config = { extra = {} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 7,                                        
    blueprint_compat=false,                             
    eternal_compat=true,         
    perishable_compat = true,                  
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'ryan',                                

    calculate = function(self,card,context)
        if context.remove_playing_cards and (not context.blueprint) then
            for k, v in ipairs(context.removed) do
                if v.seal ~= nil then 
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({
                        func = (function()
                            G.E_MANAGER:add_event(Event({
                                func = function() 
                                    local carde = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'car')
                                    carde:add_to_deck()
                                    G.consumeables:emplace(carde)
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end}))   
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.BLUE})                       
                            return true
                        end)}))
                    end
                end
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end
}

SMODS.Atlas({
    key = "mik",
    path = "j_mik.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "mik",                                  
    config = { extra = {} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 10,                                        
    blueprint_compat=false,                             
    eternal_compat=true,   
    perishable_compat = true,                        
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'mik',                                

    calculate = function(self,card,context)
        if context.open_booster and #G.jokers.cards < G.jokers.config.card_limit and (not context.blueprint) then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                play_sound('timpani')
                local card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, 'mik')
                card:add_to_deck()
                G.jokers:emplace(card)
                return true end }))
            delay(0.6)
            return { extra = { focus = card, message = 'PERSONA!', colour = G.C.RED } }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end
}

SMODS.Atlas({
    key = "hydrus",
    path = "j_hydrus.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "hydrus",                                  
    config = { extra = {x_mult = 5, isActive = true} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 6,                                        
    blueprint_compat=true,                             
    eternal_compat=true,  
    perishable_compat = true,                        
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'hydrus',                                

    calculate = function(self,card,context)
        if context.cardarea == G.jokers and context.joker_main then
            return{
                x_mult = card.ability.extra.x_mult,
                card = card
            }
        end
        G.SETTINGS.GAMESPEED = 0.5 
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult} }
    end
}

SMODS.Atlas({
    key = "jude",
    path = "j_jude.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "jude",                                  
    config = { extra = {mult = 0.56714, current_hands = 1} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 1,                                        
    cost = 3,                                        
    blueprint_compat=true,                             
    eternal_compat=true,           
    perishable_compat = true,                
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'jude',                                

    calculate = function(self,card,context)
        if (context.after or context.pre_discard) and context.cardarea == G.jokers and (not context.blueprint) then
            card.ability.extra.current_hands = card.ability.extra.current_hands + 1
                return {
                    message = 'Bromega',
                    colour = G.C.RED
                }
        end
        if context.joker_main and context.cardarea == G.jokers then
            return{
                mult = card.ability.extra.mult * card.ability.extra.current_hands,
                card = card
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.mult, card.ability.extra.mult*card.ability.extra.current_hands} }
    end
}

SMODS.Atlas({
    key = "influ",
    path = "j_influ.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "influ",                                  
    config = { extra = {x_chips = 0.1, current_x_chips = 1} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 2,                                        
    cost = 5,                                        
    blueprint_compat=true,                             
    eternal_compat=true,                 
    perishable_compat = true,          
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'influ',                                

    calculate = function(self,card,context)
        if context.selling_card and (not context.blueprint) then
            card.ability.extra.current_x_chips = card.ability.extra.current_x_chips + card.ability.extra.x_chips
            G.E_MANAGER:add_event(Event({
                    func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')}); return true
                end}))
        end
        if context.joker_main and context.cardarea == G.jokers then
            return{
                x_chips = card.ability.extra.current_x_chips,
                card = card
            }
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_chips, card.ability.extra.current_x_chips} }
    end
}

SMODS.Atlas({
    key = "bittersweet",
    path = "j_bittersweet.png",
    px = 71,
    py = 95
})
SMODS.Joker{
    key = "bittersweet",                                  
    config = { extra = {num = 1, hand = 'High Card'} },                
    pos = { x = 0, y = 0 },             
    pools = {["LRRmodAddition"] = true},            
    rarity = 3,                                        
    cost = 9,                                        
    blueprint_compat=false,                             
    eternal_compat=true,   
    perishable_compat = true,                        
    unlocked = true,                                    
    discovered = false,                                 
    effect=nil,                                        
    soul_pos=nil,                                        
    atlas = 'bittersweet',                                

    set_ability = function(self, card, initial, delay_sprites)
		local _poker_hands = {}
		for k, v in pairs(G.GAME.hands) do
			if v.visible then
				_poker_hands[#_poker_hands + 1] = k
			end
		end
		card.ability.extra.hand = _poker_hands[math.random(1, #_poker_hands)]
        card.ability.extra.num = math.random(1, G.GAME.round_resets.hands or 4)
	end,

    calculate = function(self,card,context)
        if context.end_of_round and context.cardarea == G.jokers and (not context.blueprint) then
            local _poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.visible then
                    _poker_hands[#_poker_hands + 1] = k
                end
            end
            card.ability.extra.hand = _poker_hands[math.random(1, #_poker_hands)]
            card.ability.extra.num = math.random(1, G.GAME.round_resets.hands or 4)
            return {
                extra = { focus = card, message = 'Reset!'},
            }
        end
        if context.before and context.cardarea == G.jokers and (not context.blueprint) then
            if G.GAME.current_round.hands_played == card.ability.extra.num - 1 and context.scoring_name == card.ability.extra.hand then
                for k, v in ipairs(context.scoring_hand) do
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:set_edition({negative = true}, true)
                            v:juice_up()
                            return true
                        end
                        }))
                end
            end
        end
    end;

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.num, localize(card.ability.extra.hand, "poker_hands")} }
    end
}

function showCrash()
    play_sound('lrr_bsod', 1, 100)
    sleep(2)
    local file_data = assert(NFS.newFileData("full_path"),("Samamba got far on Hatred, too bad they hit em with the 'O dispositivo encontrou um problem e precisa ser reiniciado. Estarmos coletando algumas informacoes sobre o erro e, em seguida, reiniciaremos para voce.'"))
end

function sleep(seconds)
    local start_time = os.time()
    repeat until os.time() > start_time + seconds
end
