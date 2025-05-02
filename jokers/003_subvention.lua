
-- create global var to keep track of use count tag
-- check lovely patch for implementation
local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.used_tag_count = 0 
  return ret
end

-- Common Joker
-- Earn $1 per used tag at end of round
SMODS.Joker {
  key = 'subvention',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = {  } },
  rarity = 1,
  atlas = 'VFAtlas',
  pos = { x = 2, y = 0 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { G.GAME.used_tag_count } }
  end,
  -- this function displays a row in the end of round screen
  calc_dollar_bonus =  function(self, card)
    if G.GAME.used_tag_count > 0 then
      table.insert(G.GAME.dead_letters_buffer, G.GAME.used_tag_count)
      return G.GAME.used_tag_count
    end
  end
}
