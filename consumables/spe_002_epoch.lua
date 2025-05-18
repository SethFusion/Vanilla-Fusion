
-- Sticker - mostly a visual clue that a playing card has additional bonuses
-- not granted by an enhancement, edition, or seal
SMODS.Sticker({
  key = 'buffed',
  atlas = 'VFAtlas',
  badge_colour = HEX('84c5d2'),
  pos = { x = 6, y = 3 },
  rate = 0.0
})

-- Spectral Card
-- Select an enhanced card. Add it's enhancement as a permanent bonus and 
-- remove enhancement (Wild and Probabilities excluded)
SMODS.Consumable({
  set = 'Spectral',
  key = 'epoch',
  atlas = 'VFAtlas',
  pos = { x = 8, y = 3 },
  cost = 4,
  discovered = false,
  loc_vars = function(self, info_queue)
    return {}
  end,
  
  -- Checks selected cards to make sure they meet criteria for use
  -- Must have 1 playing card selected with an enhancement of some kind, excluding wild and lucky
  can_use = function(self, card)
    if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or
        any_state then
      if #G.hand.highlighted == 1 and G.hand.highlighted[1].ability.effect ~= 'Base'
          and G.hand.highlighted[1].ability.effect ~= 'Wild Card' and G.hand.highlighted[1].ability.effect ~= 'Lucky Card' then
        return true
      end
    end
  end,
  
  -- use function
  -- adds enhancement as perma bonus
  use = function(card, area, copier)
    local selected = G.hand.highlighted[1]
    
    if selected.ability.effect == 'Bonus Card' then
      selected.ability.perma_bonus = selected.ability.perma_bonus + 30
      
    elseif selected.ability.effect == 'Mult Card' then
      selected.ability.perma_mult = selected.ability.perma_mult + 4
      
    elseif selected.ability.effect == 'Glass Card' and selected.ability.perma_x_mult == 0 then
      selected.ability.perma_x_mult = selected.ability.perma_x_mult + 1
    elseif selected.ability.effect == 'Glass Card' and selected.ability.perma_x_mult > 0 then
      selected.ability.perma_x_mult = selected.ability.perma_x_mult + 2
      
    elseif selected.ability.effect == 'Steel Card' and selected.ability.perma_h_x_mult == 0 then
      selected.ability.perma_h_x_mult = selected.ability.perma_h_x_mult + 0.5
    elseif selected.ability.effect == 'Steel Card' and selected.ability.perma_h_x_mult >= 0 then
      selected.ability.perma_h_x_mult = selected.ability.perma_h_x_mult + 1.5
      
    elseif selected.ability.effect == 'Stone Card' then
      selected.ability.perma_bonus = selected.ability.perma_bonus + 50
      
    elseif selected.ability.effect == 'Gold Card' then
      selected.ability.perma_h_dollars = selected.ability.perma_h_dollars + 3
    end
    
    play_sound('tarot1')
    selected:juice_up()
    -- remove whatever enhanement the card has
    selected:set_ability(G.P_CENTERS['c_base'])
    
    -- add buffed sticker visual
    selected.ability['vfusion_buffed'] = 'vfusion_buffed'
    
    G.hand:unhighlight_all()
  end
})
