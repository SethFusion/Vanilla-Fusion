
-- Rare Joker
-- 1 in 5 chance to add an enhancement 
-- 1 in 20 chance to add an edition to every scored card
SMODS.Joker {
  key = 'benediction',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { enh_odds_upper = 5,
                       edd_odds_upper = 20 } },
  rarity = 3,
  atlas = 'VFAtlas',
  pos = { x = 4, y = 3 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { G.GAME.probabilities.normal, 
                      card.ability.extra.enh_odds_upper,
                      card.ability.extra.edd_odds_upper } }
  end,
  calculate = function(self, card, context)
    -- before hand is scored trigger
    if context.before then
      -- for each scoring playing card
      for i = 1, #context.scoring_hand do
        -- if card has no enhancement, run odds
        if context.scoring_hand[i].ability.effect == 'Base' then
          local num = pseudorandom('ben_enhanc') < (G.GAME.probabilities.normal / card.ability.extra.enh_odds_upper)
          local multiverse = pseudorandom('multiverse_ben_enhanc') < (G.GAME.probabilities.normal / card.ability.extra.enh_odds_upper)
          if num or (G.GAME.multiverse and multiverse) then
            if (G.GAME.multiverse and multiverse) and not num then
                card_eval_status_text(
                card, 'extra', nil, nil, nil,
                {message = 'Multiverse!', colour = G.C.CHANCE}
              )
            end
            
            play_sound('tarot1')
            context.scoring_hand[i]:juice_up()
            context.scoring_hand[i]:set_ability(G.P_CENTERS[SMODS.poll_enhancement({key = 'ben_enhanc1', guaranteed  = true})])
          end
        end
        
        -- if card has no edition, run odds
        if not context.scoring_hand[i].edition then
          local num = pseudorandom('ben_edit') < (G.GAME.probabilities.normal / card.ability.extra.edd_odds_upper)
          local multiverse = pseudorandom('multiverse_ben_edit') < (G.GAME.probabilities.normal / card.ability.extra.edd_odds_upper)
          if num or (G.GAME.multiverse and multiverse) then
            if (G.GAME.multiverse and multiverse) and not num then
              card_eval_status_text(
                card, 'extra', nil, nil, nil,
                {message = 'Multiverse!', colour = G.C.CHANCE}
              )
            end
            
            context.scoring_hand[i]:juice_up()
            context.scoring_hand[i]:set_edition(poll_edition('ben_edit1', nil, true, true), true, false)
          end
        end
      end
    end
  end
}
