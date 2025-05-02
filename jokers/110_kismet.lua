
-- create global var to keep track of kismet being active
-- see lovely patches for implementation
local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.kismet = false 
  return ret
end

-- Uncommon Joker
-- gain 1 joker slot when boos blind is defeated
-- Jokers cannot be sold or destroyed
SMODS.Joker {
  key = 'kismet',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = false,
  config = { extra = {  } },
  rarity = 2,
  atlas = 'VFAtlas',
  pos = { x = 9, y = 2 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { } }
  end,
  
  calculate = function(self, card, context)
   -- end of round on boss blind -> increase joker limit
    if context.end_of_round and context.cardarea == G.jokers and not context.blueprint and G.GAME.blind.boss then
      G.jokers.config.card_limit = G.jokers.config.card_limit + 1
    end
  end,

  add_to_deck = function(self, card, from_debuff)
    G.GAME.kismet = true
  end, 
  
  remove_from_deck = function(self, card, from_debuff)
    -- if you have duplicate jokers, do not disable the global var
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i].label == 'j_vfusion_kismet' then
        return
      end
    end
    G.GAME.kismet = false
  end
}