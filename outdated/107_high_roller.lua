
-- removed for being boring and mostly not useful 

-- Uncommon Joker
-- Gain x1 Mult for every $100 you have (100 is x2 mult, 200 is x3 mult, etc.)
SMODS.Joker {
  key = 'high_roller',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = {  } },
  rarity = 2,
  atlas = 'VFAtlas',
  pos = { x = 6, y = 2 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { math.floor(G.GAME.dollars / 100) + 1 } } 
  end,
  calculate = function(self, card, context)
    -- main calc during hand score
    local xmult = math.floor(G.GAME.dollars / 100) + 1
    if context.joker_main and xmult > 0 then
      return {
        xmult = xmult
      }
    end
  end
}