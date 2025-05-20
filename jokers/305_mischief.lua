
-- Legendary Joker
-- Removes editions from all jokers and playing cards when blind is selected. 
-- Gains x2 Mult for every edition removed. (Negative excluded)
SMODS.Joker {
  key = 'mischief',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { mult_gain = 2,
                       xmult = 1 } },
  rarity = 4,
  atlas = 'VFAtlas',
  pos = { x = 4, y = 1 },
  soul_pos = { x = 9, y = 1 },
  cost = 10,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult_gain,
                      card.ability.extra.xmult } }
  end,
  
  calculate = function(self, card, context)
    -- main calc during hand score
    if context.joker_main and card.ability.extra.xmult > 1 then
      return {
        xmult = card.ability.extra.xmult
      }
    end
    
    -- blind selected trigger -> look through jokers and remove editions
    if context.setting_blind then
      local msg = ''
      
      -- iterate through jokers
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].edition and G.jokers.cards[i].edition.key ~= 'e_negative' then
          G.jokers.cards[i]:set_edition(nil)
          card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.mult_gain
          msg = 'X'..card.ability.extra.xmult..' Mult'
        end
      end
      
      -- iterate through deck
      for i = 1, #G.deck.cards do
        if G.deck.cards[i].edition then
          G.deck.cards[i]:set_edition(nil)
          card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.mult_gain
          msg = 'X'..card.ability.extra.xmult..' Mult'
        end
      end
      
      return {
        message = msg
      }
    end
  end
}
