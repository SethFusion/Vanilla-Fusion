
-- create global var to keep track of etteilla being active
local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.etteilla = false 
  return ret
end

-- Legendary Joker
-- Every used Tarot card gives one copy of that card
SMODS.Joker {
  key = 'etteilla',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = false,
  config = { extra = {  } },
  rarity = 4,
  atlas = 'VFAtlas',
  pos = { x = 1, y = 1 },
  cost = 10,
  loc_vars = function(self, info_queue, card)
    return { vars = { 0.2, (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot or 0) * 0.2 + 1 } }
  end,
  
  add_to_deck = function(self, card, from_debuff)
    G.GAME.etteilla = true
  end, 
  
  remove_from_deck = function(self, card, from_debuff)
    -- if you have multiple Etteilla jokers, don't reset the global var
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i].label == 'j_vfusion_etteilla' then
        return
      end
    end
    G.GAME.etteilla = false
  end
}
