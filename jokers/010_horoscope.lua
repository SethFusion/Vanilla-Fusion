
-- Common Joker
-- A random scoring card in your winning hand is given a blue seal
SMODS.Joker {
  key = 'horoscope',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { poker_hand = 'High Card' } },
  rarity = 1,
  atlas = 'VFAtlas',
  pos = { x = 9, y = 0 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_TAGS.tag_orbital
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
      -- last_hand is defined in the divination joker, not vanilla
      G.GAME.last_hand = context.scoring_name
    end
    
    -- end of round trigger
    if context.end_of_round and context.cardarea == G.jokers then
      local msg = {message = localize('k_reset')}
      local curr_hand = card.ability.extra.poker_hand
      -- if last hand played was our target hand, create tag
      if G.GAME.last_hand == card.ability.extra.poker_hand then
        G.E_MANAGER:add_event(Event({
          func = function()
            G.hand_text_area.blind_chips:juice_up()
            G.hand_text_area.game_chips:juice_up()
            play_sound('tarot1')
            -- creates the orbital tag
            local tag = Tag('tag_orbital')
            tag.ability.orbital_hand = curr_hand
            add_tag(tag)
            return true
          end
        }))
        msg = {message = 'Foretold!', colour = G.C.BLUE}
      end
      
      -- pick the next target hand 
      local _poker_hands = {}
      for k, v in pairs(G.GAME.hands) do
        if v.visible and k ~= card.ability.extra.poker_hand then _poker_hands[#_poker_hands+1] = k end
      end
      card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, pseudoseed('horoscope'))
      return msg
    end
  end
}


