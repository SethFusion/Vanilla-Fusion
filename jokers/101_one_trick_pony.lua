
-- Unommon Joker
-- earn $1 every consecutive high card, reset if any other hand it played
SMODS.Joker {
  key = 'one_trick_pony',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { money = 0, 
                       money_gain = 1 } },
  rarity = 2,
  atlas = 'VFAtlas',
  pos = { x = 0, y = 2 },
  cost = 7,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money, 
                      card.ability.extra.money_gain } }
  end,
  calculate = function(self, card, context)
    -- before hand scored trigger to check if high card is played, 
    -- add $1 if it was
    if context.before and not context.blueprint then
      if context.scoring_name == 'High Card' then
        card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_gain
        return {
          message = '$'..card.ability.extra.money,
          colour = G.C.IMPORTANT,
          card = card
        } 
      -- reset to 0 if not high card and not already at 0
      elseif card.ability.extra.money > 0 then
        card.ability.extra.money = 0
        return {
          message = 'Reset!',
          card = card
        }
      end
    end
  end,
  
  -- this function displays a row in the end of round screen
  calc_dollar_bonus =  function(self, card)
    if card.ability.extra.money > 0 then
      table.insert(G.GAME.dead_letters_buffer, card.ability.extra.money)
      return card.ability.extra.money
    end
  end
}
