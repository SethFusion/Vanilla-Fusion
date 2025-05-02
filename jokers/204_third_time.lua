
-- Rare Joker
-- every third scoring 3 gives x3 mult
SMODS.Joker {
  key = 'third_time',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { xmult = 3,
                       count = 2,
                       msg = '2 Remaining'} },
  rarity = 3,
  atlas = 'VFAtlas',
  pos = { x = 0, y = 3 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult,
                      card.ability.extra.msg } }
  end,
  calculate = function(self, card, context)
    -- individual scoring -> is 3 -> update card
    if context.individual and not context.blueprint and context.cardarea == G.play and context.other_card:get_id() == 3 then
      if card.ability.extra.count > 0 then
        card.ability.extra.count = card.ability.extra.count - 1
        if card.ability.extra.count == 0 then
          card.ability.extra.msg = 'Next 3!'
        else
          card.ability.extra.msg = card.ability.extra.count..' Remaining'
        end
      else 
        -- reset count and return mult
        card.ability.extra.count = 2
        return {
          xmult = card.ability.extra.xmult
        }
      end
    end
  end
}
