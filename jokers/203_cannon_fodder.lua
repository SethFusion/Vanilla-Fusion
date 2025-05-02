
-- Rare Joker
-- destroy all played cards after hand and earn 0.2 mult per card destroyed
SMODS.Joker {
  key = 'cannon',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { mult_gain = 0.2,
                       xmult = 1 } },
  rarity = 3,
  atlas = 'VFAtlas',
  pos = { x = 1, y = 3 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult_gain,
                      card.ability.extra.xmult } }
  end,
  calculate = function(self, card, context)
    local played_card = context.other_card
    -- individual scoring trigger -> mark to be destroyed
    if context.individual and context.cardarea == G.play and not context.blueprint then
      return {
        remove = true, 
        card = played_card
      }
    end
    
    -- main calc during hand score
    if context.joker_main then
      return {
        xmult = card.ability.extra.xmult
      }
    end
    
    -- cards marked for removal trigger -> add mult
    if context.destroying_card and not context.blueprint then
      card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.mult_gain
      card_eval_status_text(
          card, 'extra', nil, nil, nil,
          {message = 'X'..card.ability.extra.xmult, colour = G.C.RED}
        )
      return true
    end
  end
}
