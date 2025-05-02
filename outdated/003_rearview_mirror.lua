
-- removed for being too simple and boring

-- Common Joker
-- Gains a cip for every card discarded
SMODS.Joker {
  key = 'rearview_mirror',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { chips = 0, 
                       chip_gain = 1 } },
  rarity = 1,
  atlas = 'VFAtlas',
  pos = { x = 2, y = 0 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, 
                      card.ability.extra.chip_gain } }
  end,
  calculate = function(self, card, context)
    -- main calc during hand score
    if context.joker_main then
      return {
        chips = card.ability.extra.chips
      }
    end
    
    -- Discard trigger -> add chips to this card
    if context.discard and not context.blueprint then
      sendDebugMessage('entered function!', "debug")
      card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
      return {
        delay = 0.2,
        message = localize{ type = 'variable', key = 'a_chips', vars = { card.ability.extra.chip_gain } },
        colour = G.C.BLUE
      }
    end
  end
}
