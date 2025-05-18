
-- Spectral Card
-- Select up to four cards. All selected cards are transformed into a random selected card
SMODS.Consumable({
  set = "Spectral",
  key = "geist",
  atlas = 'VFAtlas',
  pos = { x = 5, y = 3 },
  cost = 4,
  discovered = false,
  loc_vars = function(self, info_queue)
    return {}
  end,
  
  -- more than one card but less than 5
  can_use = function(self, card)
    if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or
      any_state then
      if #G.hand.highlighted > 1 and #G.hand.highlighted < 5 then
        return true
      end
    end
  end,
  
  -- use function
  use = function(card, area, copier)
    local copier = pseudorandom_element(G.hand.highlighted, pseudoseed('geist'))
    for i=1, #G.hand.highlighted do
      local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
      G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
      G.hand.highlighted[i]:flip();
      play_sound('card1', percent);
      G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
    end
    
    for i = 1, #G.hand.highlighted do
      G.E_MANAGER:add_event(Event({ trigger = "after", delay = 0.25, func = function() 
        copy_card(copier, G.hand.highlighted[i])
        G.hand.highlighted[i].ability['vfusion_buffed'] = copier.ability['vfusion_buffed'] or nil
      return true end }))
    end
    
    for i=1, #G.hand.highlighted do
      local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
      G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
    end
    
    for i=1, #G.hand.highlighted do
      G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand:unhighlight_all();return true end }))
    end
    
  end
})
