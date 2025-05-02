
-- this joker was fine, but replaced with Layaway because I liked it more

-- create global var to keep track of shareholder being active
local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.shareholder = false 
  return ret
end

-- Common Joker
-- All probabilities are rolled twice when possible
SMODS.Joker {
  key = 'shareholder',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = false,
  config = { extra = {  } },
  rarity = 1,
  atlas = 'VFAtlas',
  pos = { x = 7, y = 0 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { } }
  end,

  add_to_deck = function(self, card, from_debuff)
    G.GAME.shareholder = true
  end,
  
  remove_from_deck = function(self, card, from_debuff)
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i].label == 'j_vfusion_shareholder' then
        return
      end
    end
    G.GAME.shareholder = false
  end
}


