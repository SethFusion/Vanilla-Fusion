
-- Uncommon Joker
-- Next shop size increases by the number of scored 7s in your winning hand
SMODS.Joker {
  key = 'jackpot',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { count = 0 } },
  rarity = 2,
  atlas = 'VFAtlas',
  pos = { x = 4, y = 0 },
  cost = 7,
  loc_vars = function(self, info_queue, card)
    return { vars = {  } }
  end,

  calculate = function(self, card, context)
    if not context.blueprint then
      -- individual cards scoring trigger -> is a 7? -> add to var
      if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 then
        card.ability.extra.count = card.ability.extra.count + 1
      end
      
      -- before score trigger -> rest count to 0
      -- this ensures that only the winning hand increases shop size,
      -- which will never be more tahn five 7s at once (unless you have duplicate jokers)
      if context.before then
        card.ability.extra.count = 0
      end
      
      -- end of round trigger -> increase shop size by count
      if context.end_of_round and context.cardarea == G.jokers then
        G.GAME.shop.joker_max = G.GAME.shop.joker_max + card.ability.extra.count
      end
      
      -- leave shop trigger -> reset count and shop size
      if context.ending_shop then
        G.GAME.shop.joker_max = G.GAME.shop.joker_max - card.ability.extra.count
        card.ability.extra.count = 0
      end
    end
  end,
  
  -- if card is sold or destroyed in the shop, we need to reset shop for next round
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.shop.joker_max = G.GAME.shop.joker_max - card.ability.extra.count
  end
}