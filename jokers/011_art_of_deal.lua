
-- create global var to keep track of joker being active
local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.art = false 
  return ret
end

-- Common Joker
-- Cards sell for their buy price
SMODS.Joker {
  key = 'art',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = false,
  config = { extra = {  } },
  rarity = 1,
  atlas = 'VFAtlas',
  pos = { x = 8, y = 2 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { } }
  end,
  
  -- add to deck trigger -> change sell values
  add_to_deck = function(self, card, from_debuff)
    -- set our global to true first, this is checked in Card:set_cost() through a lovely patch
    -- to initialize the sell cost of new cards
    G.GAME.art = true
    -- iterate through jokers, add back half of it's original buy price
    for i = 1, #G.jokers.cards do
      G.jokers.cards[i]:set_cost()
    end
    -- iterate through consumables as well
    for i = 1, #G.consumeables.cards do
      G.consumeables.cards[i]:set_cost()
    end
    -- iterate through shop
    if G.shop_jokers and G.shop_jokers.cards then
      for i = 1, #G.shop_jokers.cards do
        G.shop_jokers.cards[i]:set_cost()
      end
    end
  end,
  
  remove_from_deck = function(self, card, from_debuff)
    -- check for another copy of this joker, do nothing if it is still active
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i].label == 'j_vfusion_art' then
        return
      end
    end
    
    G.GAME.art = false
    
    -- iterate all of these areas again and reset sell prices
    for i = 1, #G.jokers.cards do
      G.jokers.cards[i]:set_cost()
    end
    
    for i = 1, #G.consumeables.cards do
      G.consumeables.cards[i]:set_cost()
    end
    
    if G.shop_jokers and G.shop_jokers.cards then
      for i = 1, #G.shop_jokers.cards do
        G.shop_jokers.cards[i]:set_cost()
      end
    end
  end
}