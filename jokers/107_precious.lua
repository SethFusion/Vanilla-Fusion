
-- create global var to keep track of precious being active
local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.precious = false 
  return ret
end

-- Uncommon Joker
-- Steel cards are considered Gold
-- Gold cards are considered Steel
SMODS.Joker {
  key = 'precious_joker',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = false,
  config = { extra = {  } },
  rarity = 2,
  atlas = 'VFAtlas',
  pos = { x = 6, y = 2 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
    info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
    return { vars = {  } } 
  end,
  
  add_to_deck = function(self, card, from_debuff)
    G.GAME.precious = true
    
    -- iterate through all playing cards
    for i = 1, #G.playing_cards do
      if G.playing_cards[i].ability.effect == 'Steel Card' then
        G.playing_cards[i].ability.h_dollars = 3
      elseif G.playing_cards[i].ability.effect == 'Gold Card' then
        G.playing_cards[i].ability.h_x_mult = 1.5
      end
    end
  end, 
  
  remove_from_deck = function(self, card, from_debuff)
    -- if you have multiple precious jokers, don't reset the global var
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i].label == 'j_vfusion_precious_joker' then
        return
      end
    end
    G.GAME.precious = false
    
    -- iterate through all playing cards
    for i = 1, #G.playing_cards do
      if G.playing_cards[i].ability.effect == 'Steel Card' then
        G.playing_cards[i].ability.h_dollars = 0
      elseif G.playing_cards[i].ability.effect == 'Gold Card' then
        G.playing_cards[i].ability.h_x_mult = 0
      end
    end
  end
}