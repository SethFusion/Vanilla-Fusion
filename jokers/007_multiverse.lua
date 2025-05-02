
-- create global var to keep track of multiverse being active
-- most all functionality comes from lovely patches
local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.multiverse = false 
  return ret
end

-- Common Joker
-- All probabilities are re-rolled once if they fail
SMODS.Joker {
  key = 'multiverse',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = false,
  config = { extra = {  } },
  rarity = 1,
  atlas = 'VFAtlas',
  pos = { x = 6, y = 0 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { } }
  end,

  add_to_deck = function(self, card, from_debuff)
    G.GAME.multiverse = true
  end, 
  
  remove_from_deck = function(self, card, from_debuff)
    -- if you have multiple Multiverse jokers, don't reset the global var
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i].label == 'j_vfusion_multiverse' then
        return
      end
    end
    G.GAME.multiverse = false
  end
}