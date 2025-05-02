
-- Common Joker
-- 1 in 3 chance to create a planet card for high card
-- pair, or two pair every hand played. 
SMODS.Joker {
  key = 'betting_low',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { odds_upper = 3 } },
  rarity = 1,
  atlas = 'VFAtlas',
  pos = { x = 1, y = 0 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_pluto
    info_queue[#info_queue + 1] = G.P_CENTERS.c_mercury
    info_queue[#info_queue + 1] = G.P_CENTERS.c_uranus
    return { vars = { G.GAME.probabilities.normal, 
                      card.ability.extra.odds_upper } }
  end,
  calculate = function(self, card, context)
    -- main calc during hand score -> run odds
    if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      -- determine which planet to create
      local num = pseudorandom('betting_low') < (G.GAME.probabilities.normal / card.ability.extra.odds_upper)
      local multiverse = pseudorandom('multiverse_betting_low') < (G.GAME.probabilities.normal / card.ability.extra.odds_upper)
      if num or (G.GAME.multiverse and multiverse) then
        -- buffer is incremented to make sure we don't spawn too many
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        if (G.GAME.multiverse and multiverse) and not num then
          card_eval_status_text(
            card, 'extra', nil, nil, nil,
            {message = 'Multiverse!', colour = G.C.CHANCE}
          )
        end
        
        card_name = pseudorandom_element({'c_pluto','c_mercury','c_uranus'}, pseudoseed('betting_low2'))
        
        card_eval_status_text(
          card, 'extra', nil, nil, nil,
          {message = 'Score!', colour = G.C.SECONDARY_SET.Planet}
        )
        
        G.E_MANAGER:add_event(Event({
          func = function()
            -- reset consumeable_buffer
            G.GAME.consumeable_buffer = 0
            SMODS.add_card({
              set = 'Planet', 
              area = G.consumeables, 
              skip_materialize = false, 
              key = card_name,
              key_append = 'betting_low', 
              no_edition = true
            })
          return true
          end
        }))
      end
    end
  end
}
