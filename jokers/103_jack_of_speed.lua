
-- Uncommon Joker
-- Every played card has a 1 in 4 chance to become a jack
-- and 1 in 4 chance to become glass
SMODS.Joker {
  key = 'jack_of_speed',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { odds_upper = 4 } },
  rarity = 2,
  atlas = 'VFAtlas',
  pos = { x = 2, y = 2 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
    return { vars = { G.GAME.probabilities.normal, 
                      card.ability.extra.odds_upper } }
  end,
  calculate = function(self, card, context)
    -- hand played trigger -> is card not a Jack (id ~= 11)? -> run odds, convert to jack
    if context.after then
      for i = 1, #context.scoring_hand do
        local played_card = context.scoring_hand[i]
        local num = pseudorandom('jack_of_speed') < (G.GAME.probabilities.normal / card.ability.extra.odds_upper)
        if not num and G.GAME.multiverse then
          num = pseudorandom('multiverse_jack_of_speed') < (G.GAME.probabilities.normal / card.ability.extra.odds_upper)
        end
        
        -- if card is not already a jack and we hit the 1 in 4
        if played_card:get_id() ~= 11 and num then
          -- event that flips the card face down
          local percent = 1.15 - (1-0.999)/(#G.hand.highlighted-0.998)*0.3
          G.E_MANAGER:add_event(Event({ trigger = "after", delay = 0.25, func = function() 
            played_card:flip()
            play_sound('card1', percent)
            played_card:juice_up(0.3, 0.3)
          return true end }))
          
          card_eval_status_text(
            card, 'extra', nil, nil, nil,
            {message = 'Jacked!', colour = G.C.JOKER_GREY}
          )
          G.E_MANAGER:add_event(Event({ trigger = "after", delay = 0.25, func = function() 
            -- change the card into a jack and flip back over
            delay(0.1)
            SMODS.change_base(played_card, nil, 'Jack')
            delay(0.1)
            played_card:flip()
            play_sound('card1', percent)
            played_card:juice_up(0.3, 0.3)
          return true end }))
        -- if card is a a jack and we hit the 1 in 4
        elseif num then
          -- event that flips the card face down
          local percent = 1.15 - (1-0.999)/(#G.hand.highlighted-0.998)*0.3
          G.E_MANAGER:add_event(Event({ trigger = "after", delay = 0.25, func = function() 
            played_card:flip()
            play_sound('card1', percent)
            played_card:juice_up(0.3, 0.3)
          return true end }))
          
          card_eval_status_text(
            card, 'extra', nil, nil, nil,
            {message = 'Speed!', colour = G.C.JOKER_GREY}
          )
          G.E_MANAGER:add_event(Event({ trigger = "after", delay = 0.25, func = function() 
            -- card beceoms glass and flip back over
            delay(0.1)
            played_card:set_ability(G.P_CENTERS['m_glass'])
            delay(0.1)
            played_card:flip()
            play_sound('card1', percent)
            played_card:juice_up(0.3, 0.3)
          return true end }))
        end
      end
    end
  end
}
