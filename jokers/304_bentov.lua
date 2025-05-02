
-- Legendary Joker
-- all editionless jokers become negative when this card is sold
SMODS.Joker {
  key = 'bentov',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = {  } },
  rarity = 4,
  atlas = 'VFAtlas',
  pos = { x = 3, y = 1 },
  cost = 10,
  loc_vars = function(self, info_queue, card)
    return { vars = {  } }
  end,
  
  calculate = function(self, card, context)
    -- selling card trigger
    if context.selling_self then
      -- iterate through jokers
      for i = 1, #G.jokers.cards do
        -- if it has no edition, become negative
        if not G.jokers.cards[i].edition then
          G.jokers.cards[i]:set_edition({negative = true})
        end
      end
    end
  end
}
