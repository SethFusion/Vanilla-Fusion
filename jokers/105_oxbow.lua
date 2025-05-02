
-- Uncommon Joker
-- +25 Chips for every $1 you have under $0
SMODS.Joker {
  key = 'oxbow',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = {  } },
  rarity = 2,
  atlas = 'VFAtlas',
  pos = { x = 4, y = 2 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { math.min(0, G.GAME.dollars) * -25 } }
  end,
  calculate = function(self, card, context)
    -- main calc during hand score
    local chips = math.min(0, G.GAME.dollars) * -25
    if context.joker_main and chips > 0 then
      return {
        chips = chips
      }
    end
  end
}