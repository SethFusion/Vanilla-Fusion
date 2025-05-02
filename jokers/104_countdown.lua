
-- Uncommon Joker
-- Every scored 10 reduces the countdown by 1.
-- +0.5x mult when it reaches 0
SMODS.Joker {
  key = 'countdown',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { mult_gain = 0.5,
                       xmult = 1, 
                       count = 10 } },
  rarity = 2,
  atlas = 'VFAtlas',
  pos = { x = 3, y = 2 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult_gain,
                      card.ability.extra.xmult,
                      card.ability.extra.count} }
  end,
  calculate = function(self, card, context)
    -- main calc during hand score
    if context.joker_main and card.ability.extra.xmult > 1 then
      return {
        xmult = card.ability.extra.xmult
      }
    end
    
    -- trigger during hand calc -> scored 10s lower countdown
    if not context.blueprint and context.individual and context.cardarea == G.play and context.other_card:get_id() == 10 then
      card.ability.extra.count = card.ability.extra.count - 1
      
      -- add to mult when countdown reaches 0 and reset countdown
      if card.ability.extra.count == 0 then
        card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.mult_gain
        card.ability.extra.count = 10
        card_eval_status_text(
          card, 'extra', nil, nil, nil,
          {message = 'Liftoff!', colour = G.C.RED, delay = 1}
        )
      -- otherwise just display what the coutdown is currently at
      else
        card_eval_status_text(
          card, 'extra', nil, nil, nil,
          {message = ''..card.ability.extra.count, colour = G.C.IMPORTANT}
        )
      end
    end
  end
}