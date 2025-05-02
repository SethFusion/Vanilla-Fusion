
-- create global var to keep track of the last played hand
-- which we don't have access to at the proper context
local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.last_hand = '' 
  return ret
end

-- Common Joker
-- beating the blind by playing a (hand) creates Charm tag - changes every round 
SMODS.Joker {
  key = 'divination',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { poker_hand = 'High Card' } },
  rarity = 1,
  atlas = 'VFAtlas',
  pos = { x = 8, y = 0 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_TAGS.tag_charm
    return { vars = { localize(card.ability.extra.poker_hand, 'poker_hands') } }
  end,
  
  -- initilize first poker hand
  set_ability = function(self, card, initial, delay_sprites)
    local _poker_hands = {}
      for k, v in pairs(G.GAME.hands) do
        if v.visible then _poker_hands[#_poker_hands+1] = k end
      end
      local old_hand = card.ability.extra.poker_hand
      card.ability.extra.poker_hand = nil

      while not card.ability.extra.poker_hand do
        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, pseudoseed((self.area and self.area.config.type == 'title') and 'false_div' or 'div'))
        if card.ability.extra.poker_hand == old_hand then card.ability.extra.poker_hand = nil end
      end
  end,

  calculate = function(self, card, context)
    -- after scoring trigger -> update the last hand
    if context.after then
      G.GAME.last_hand = context.scoring_name
    end
    
    -- end of round trigger
    if context.end_of_round and context.cardarea == G.jokers then
      local msg = {message = localize('k_reset')}
      
      -- if last hand played was our target hand, create tag
      if G.GAME.last_hand == card.ability.extra.poker_hand then
        G.E_MANAGER:add_event(Event({
          func = function()
            G.hand_text_area.blind_chips:juice_up()
            G.hand_text_area.game_chips:juice_up()
            play_sound('tarot1')
            -- creates the charm tag
            add_tag(Tag('tag_charm'))
            return true
          end
        }))
        msg = {message = 'Divined!', colour = G.C.PURPLE}
      end
      
      -- pick the next target hand 
      local _poker_hands = {}
      for k, v in pairs(G.GAME.hands) do
        if v.visible and k ~= card.ability.extra.poker_hand then _poker_hands[#_poker_hands+1] = k end
      end
      card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, pseudoseed('divination'))
      return msg
    end
  end
}


