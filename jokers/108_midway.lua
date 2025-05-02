
-- Uncommon Joker
-- swaps chips and mult every time a 5 is scored
SMODS.Joker {
  key = 'midway',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { } },
  rarity = 2,
  atlas = 'VFAtlas',
  pos = { x = 7, y = 2 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { } }
  end,
  calculate = function(self, card, context)
    local played_card = context.other_card
    -- hand played trigger -> is card 5? -> return a swap
    -- thanks to SMODS for making this easy
    if context.individual and not context.blueprint and context.cardarea == G.play and played_card:get_id() == 5 then
      return {
        swap = true
      }
    end
  end
}
