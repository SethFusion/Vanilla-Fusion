
-- Common Joker
-- gains 15 chips every round, at 60, converts into 12 mult
SMODS.Joker {
  key = 'jimbos_watch',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { chips = 0, 
                       mult = 0, 
                       chip_gain = 15, 
                       mult_gain = 12 } },
  rarity = 1,
  atlas = 'VFAtlas',
  pos = { x = 0, y = 0 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, 
                      card.ability.extra.mult,
                      card.ability.extra.chip_gain,
                      card.ability.extra.mult_gain} }
  end,
  calculate = function(self, card, context)
    -- context for iterating through jokers during scoring
    if context.joker_main then
      return {
        mult = card.ability.extra.mult,
        chips = card.ability.extra.chips
      }
    end
    
    -- end of round trigger -> buff chips or convert to mult
    if context.end_of_round and not context.repetition and not context.individual and not context.game_over and not context.blueprint then
      if card.ability.extra.chips == 45 then
        card.ability.extra.chips = 0
        card.ability.extra.mult = card.ability.extra.mult + 12
        return {
          message = '+Mult!'
        }
      else 
        card.ability.extra.chips = card.ability.extra.chips + 15
        return {
          message = '+Chips!'
        }
      end
    end
  end
}
