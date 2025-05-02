
-- Uncommon Joker
-- +8 Mult for every $1 you have under $0
SMODS.Joker {
  key = 'staying_down',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = {  } },
  rarity = 2,
  atlas = 'VFAtlas',
  pos = { x = 5, y = 2 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { math.min(0, G.GAME.dollars) * -8 } }
  end,
  calculate = function(self, card, context)
    -- main calc during hand score
    local mult = math.min(0, G.GAME.dollars) * -8
    if context.joker_main and mult > 0 then
      return {
        mult = mult
      }
    end
  end
}