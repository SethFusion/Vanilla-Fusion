
-- Legendary Joker
-- 0.2x mult for every played tarot card
SMODS.Joker {
  key = 'etteilla',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = {  } },
  rarity = 4,
  atlas = 'VFAtlas',
  pos = { x = 1, y = 1 },
  cost = 10,
  loc_vars = function(self, info_queue, card)
    return { vars = { 0.2, (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot or 0) * 0.2 + 1 } }
  end,
  calculate = function(self, card, context)
    -- main calc during hand score
    if context.joker_main and G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot > 0 then
      return {
        xmult = G.GAME.consumeable_usage_total.tarot * 0.2 + 1
      }
    end
    
  end
}
