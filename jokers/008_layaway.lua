
-- create global var to keep track of joker being active
-- check lovely patch for implementation
local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  -- defaults to 'true' because of the implementation
  -- only ever gets set to false when this joker is used
  ret.layaway_used = true 
  return ret
end

-- Common Joker
-- first bought shop item is payed for at the end of next round
SMODS.Joker {
  key = 'layaway',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = false,
  config = { extra = { cost = 0,
                       text = 'Can go into debt' } },
  rarity = 1,
  atlas = 'VFAtlas',
  pos = { x = 7, y = 0 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.text } }
  end,
  
  calculate = function(self, card, context)
    -- context for first bought item that isn't a voucher
    if (context.buying_card or context.open_booster) and context.card.ability.set ~= 'Voucher' and not G.GAME.layaway_used then
      G.GAME.layaway_used = true
      -- if this item was supposed to be free, it won't cost you later
      if not context.card.ability.couponed then
        -- exact same formula to calculate cost in card.lua
        card.ability.extra.cost = math.max(1, math.floor((context.card.base_cost + context.card.extra_cost + 0.5)*(100-G.GAME.discount_percent)/100))
        card.ability.extra.text = 'Currently $'..card.ability.extra.cost
      end
      
      -- iterate through shop and reset prices
      -- we need some checks and balances to keep the game frome breaking on edge cases
      if G.shop_jokers and G.shop_jokers.cards then
        for i = 1, #G.shop_jokers.cards do
          G.shop_jokers.cards[i]:set_cost()
        end
      end
      if G.shop_booster and G.shop_booster.cards then
        for i = 1, #G.shop_booster.cards do
          G.shop_booster.cards[i]:set_cost()
        end
      end
      if G.shop_vouchers and G.shop_vouchers.cards then
        for i = 1, #G.shop_vouchers.cards do
          G.shop_vouchers.cards[i]:set_cost()
        end
      end
    end
    
    -- context to payoff at end of raound
    if context.end_of_round and context.cardarea == G.jokers then
      G.GAME.layaway_used = false
      
      if card.ability.extra.cost > 0 then
        ease_dollars(card.ability.extra.cost * -1, false)
        card_eval_status_text(
          card, 'extra', nil, nil, nil,
          {message = 'Payed Off', colour = G.C.GREY}
        )
        card.ability.extra.cost = 0
        card.ability.extra.text = 'Can go into debt'
      end
    end
    
    -- context for selling this card (you can't cheat your way into getting free stuff)
    if context.selling_self then
      if card.ability.extra.cost > 0 then
        ease_dollars(card.ability.extra.cost * -1, true)
      end
      G.GAME.layaway_used = true
    
      -- iterate through shop and reset prices
      -- we need this if selling this card is the first thing you do in the shop
      if G.shop_jokers and G.shop_jokers.cards then
        for i = 1, #G.shop_jokers.cards do
          G.shop_jokers.cards[i]:set_cost()
        end
      end
      if G.shop_booster and G.shop_booster.cards then
        for i = 1, #G.shop_booster.cards do
          G.shop_booster.cards[i]:set_cost()
        end
      end
      if G.shop_vouchers and G.shop_vouchers.cards then
        for i = 1, #G.shop_vouchers.cards do
          G.shop_vouchers.cards[i]:set_cost()
        end
      end
    end
  end
}


