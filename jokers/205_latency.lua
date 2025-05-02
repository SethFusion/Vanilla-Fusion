
-- create global var to keep track of removed cards
local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.latency_list = {} 
  return ret
end

-- Rare Joker
-- scored cards are temporarily removed from deck. 
-- When selecting the boss blind, they are returned and drawn to your hand
SMODS.Joker {
  key = 'latency',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = {  } },
  rarity = 3,
  atlas = 'VFAtlas',
  pos = { x = 3, y = 3 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = {  } }
  end,
  calculate = function(self, card, context)
    if not context.blueprint then
      local played_card = context.other_card
      -- individual scoring trigger -> mark to be destroyed and add to buffer
      -- played_card.latency is used to check for multiple copies of Latency affecting the same card
      if context.individual and context.cardarea == G.play and not played_card.latency then
        played_card.latency = true
        -- we save the each of these seperately because saving the card itself
        -- would cause issues if the game was saved and loaded
        local card_stats = {
          card_key = played_card.config.card_key,
          card_center = played_card.config.center,
          card_edition = played_card.edition,
          card_bonuses = played_card.ability
        }
        table.insert(G.GAME.latency_list, card_stats)
        return {
          remove = true, 
          card = played_card
        }
      end
      
      -- cards marked for removal trigger -> destroy
      if context.destroying_card then
        return true
      end
      
      -- if boss blind -> return cards to hand after first hand is drawn
      if G.GAME.blind.boss and context.first_hand_drawn then
        for i = 1, #G.GAME.latency_list do
          -- card_key sets suit properly, center sets enhancements properly
          local _card = create_playing_card(
            {
              front = G.P_CARDS[G.GAME.latency_list[i].card_key],
              center = G.GAME.latency_list[i].card_center
            }, 
            G.hand, nil, nil, {G.C.SECONDARY_SET.Enhanced}
          )
          -- edition is not carried over, so set it manually
          _card:set_edition(G.GAME.latency_list[i].card_edition, true, true)
          -- permanent bonuses (such as chips from Hiker) are also not carried over
          _card.ability = G.GAME.latency_list[i].card_bonuses
          
          G.hand:sort()
        end
        -- empty list for next ante
        G.GAME.latency_list = {}
      end
    end
  end
}
