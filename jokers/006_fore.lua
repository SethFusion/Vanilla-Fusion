
-- Common Joker
-- Played 4s are destroyed but give $10
SMODS.Joker {
  key = 'fore',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { } },
  rarity = 1,
  atlas = 'VFAtlas',
  pos = { x = 5, y = 0 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { } }
  end,
  calculate = function(self, card, context)
    local played_card = context.other_card
    -- individual card scoring trigger -> is card a 4? -> mark to be destroyed
    if context.individual and context.cardarea == G.play and played_card:get_id() == 4 then
      return {
        remove = true, 
        card = played_card
      }
    end
    
    -- cards marked for removal trigger -> earn $10
    if context.destroying_card and not context.blueprint and context.destroying_card:get_id() == 4 then
      ease_dollars(10, nil, true)
      return true
    end
  end
}
