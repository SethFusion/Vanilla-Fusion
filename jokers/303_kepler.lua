
-- Legendary Joker
-- Playing cards with a Blue Seal gain 0.5x held-in-hand Mult when their Blue Seal triggers
SMODS.Joker {
  key = 'kepler',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = {  } },
  rarity = 4,
  atlas = 'VFAtlas',
  pos = { x = 2, y = 1 },
  soul_pos = { x = 7, y = 1 },
  cost = 10,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS.Blue
    return { vars = {  } }
  end,
  
  calculate = function(self, card, context)
    local played_card = context.other_card
    -- end of round individual card trigger
    if context.end_of_round and context.individual and played_card:get_seal() == 'Blue' then
      played_card:juice_up()
      played_card.ability.perma_h_x_mult = played_card.ability.perma_h_x_mult + 0.5
      -- add buffed sticker visual
      played_card.ability['vfusion_buffed'] = 'vfusion_buffed'
        
      card_eval_status_text(
        played_card, 'extra', nil, nil, nil,
        {message = 'X'..(played_card.ability.perma_h_x_mult + 1) , colour = G.C.MULT}
      )
    end
  end
}
