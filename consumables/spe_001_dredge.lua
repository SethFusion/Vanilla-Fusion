
-- Spectral Card
-- Select a joker or cad with an edition
-- remove edition and add a random edition
SMODS.Consumable({
  set = "Spectral",
  key = "dredge",
  atlas = 'VFAtlas',
  pos = { x = 9, y = 3 },
  cost = 4,
  discovered = false,
  loc_vars = function(self, info_queue)
    return {}
  end,
  
  -- Checks selected cards to make sure they meet criteria for use
  -- Must have 1 joker or 1 playing card selected with an edition of some kind, excluding negative
  -- if one of each is selected, doesn't count
  can_use = function(self, card)
    if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or
      any_state then
      local joker = #G.jokers.highlighted == 1 and G.jokers.highlighted[1].edition and G.jokers.highlighted[1].edition.key ~= 'e_negative'
      local hand = #G.hand.highlighted == 1 and G.hand.highlighted[1].edition
      if (joker and #G.hand.highlighted == 0) or (hand and #G.jokers.highlighted == 0) then
        return true
      end
    end
  end,
  
  -- use function
  -- polls for a random edition, removes current edition, and adds new one
  use = function(card, area, copier)
    -- if we are looking at a joker
    if #G.jokers.highlighted == 1 then
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          local selected = G.jokers.highlighted[1]
          selected:set_edition(poll_edition('dredge_joker', nil, false, true), true, false)
          G.jokers:unhighlight_all()
          return true
        end
      }))
    -- if we are looking at a playing card
    else
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          local selected = G.hand.highlighted[1]
          selected:set_edition(poll_edition('dredge_card', nil, true, true), true, false)
          G.hand:unhighlight_all()
          return true
        end
      }))
    end
  end
})
