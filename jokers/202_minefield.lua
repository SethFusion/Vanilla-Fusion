
-- Rare Joker
-- 1 in 8 chance to de-level your most played hand and create a spectral card
SMODS.Joker {
  key = 'minefield',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { odds_upper = 8 } },
  rarity = 3,
  atlas = 'VFAtlas',
  pos = { x = 2, y = 3 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { G.GAME.probabilities.normal, 
                      card.ability.extra.odds_upper } }
  end,
  calculate = function(self, card, context)
    -- After hand trigger -> run odds
    if context.after then
      local num = pseudorandom('minefield') < (G.GAME.probabilities.normal / card.ability.extra.odds_upper)
      if not num and G.GAME.multiverse then
        num = pseudorandom('multiverse_minefield') < (G.GAME.probabilities.normal / card.ability.extra.odds_upper)
      end
        
      if num then
        -- Find true most played hand and de-level it by 1
        local most_played, _played, _order = 'High Card', -1, 100
        for k, v in pairs(G.GAME.hands) do
          if v.played > _played or (v.played == _played and _order > v.order) then
            _played = v.played
            most_played = k
          end
        end
        
        -- only delevel if hand's current level is greater than 1
        if most_played and G.GAME.hands[most_played].level > 1 then 
          
          -- custom function found below to display thing properly
          update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = most_played, level = G.GAME.hands[most_played].level})
          delevel_hand(most_played, 1)
          update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
        end
        
        -- spawn spectral card
        -- check that our consumable area is not full. if it is, we don't create a spectral card
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
          -- adding to this buffer represents the cards that will take up space after the events fire
          G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          G.E_MANAGER:add_event(Event({
            func = function()
              -- reset consumeable_buffer
              G.GAME.consumeable_buffer = 0
              SMODS.add_card({
                set = 'Spectral', 
                area = G.consumables, 
                skip_materialize = false,
                key_append = 'minefield', 
                no_edition = true
              })
            return true
            end
          }))
        end
      end 
    end
  end
}

-- code stolen and gutted from common_events.level_up_hand and common_events.update_hand_text.
-- wasn't displaying properly at the end of round because G.GAME.current_round.current_hand.chips and mult
-- were reset to 0 before events could fire off. Fine, I'll do it myself... 
function delevel_hand(hand, amount)
    G.GAME.hands[hand].level = G.GAME.hands[hand].level - amount
    
    local mult_diff = G.GAME.hands[hand].mult
    G.GAME.hands[hand].mult = G.GAME.hands[hand].s_mult + G.GAME.hands[hand].l_mult*(G.GAME.hands[hand].level - 1)
    mult_diff = mult_diff - G.GAME.hands[hand].mult
    
    local chip_diff = G.GAME.hands[hand].chips
    G.GAME.hands[hand].chips = G.GAME.hands[hand].s_chips + G.GAME.hands[hand].l_chips*(G.GAME.hands[hand].level - 1)
    chip_diff = chip_diff - G.GAME.hands[hand].chips

    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
        play_sound('tarot1')
        G.TAROT_INTERRUPT_PULSE = true
        return true end }))
    delevel_hand_text({delay = 0}, {mult = mult_diff, StatusText = true})
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
        play_sound('tarot1')
        return true end }))
    delevel_hand_text({delay = 0}, {chips = chip_diff, StatusText = true})
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
        play_sound('tarot1')
        G.TAROT_INTERRUPT_PULSE = nil
        return true end }))
    delevel_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level=G.GAME.hands[hand].level})
    update_hand_text({delay = 0}, {chips = G.GAME.hands[hand].chips, StatusText = true})
    update_hand_text({delay = 0}, {mult = G.GAME.hands[hand].mult, StatusText = true})
end

function delevel_hand_text(config, vals)
    G.E_MANAGER:add_event(Event({
    trigger = 'before',
    blockable = not config.immediate,
    delay = config.delay or 0.8,
    func = function()
        local col = G.C.RED
        if vals.chips and G.GAME.current_round.current_hand.chips ~= vals.chips then
            vals.chips = '-'..vals.chips
            G.GAME.current_round.current_hand.chips = vals.chips
            G.hand_text_area.chips:update(0)
            if vals.StatusText then 
                attention_text({
                    text = vals.chips,
                    scale = 0.8, 
                    hold = 1,
                    cover = G.hand_text_area.chips.parent,
                    cover_colour = mix_colours(G.C.CHIPS, col, 0.1),
                    emboss = 0.05,
                    align = 'cm',
                    cover_align = 'cr'
                })
            end
        end
        if vals.mult and G.GAME.current_round.current_hand.mult ~= vals.mult then
            vals.mult = '-'..vals.mult
            G.GAME.current_round.current_hand.mult = vals.mult
            G.hand_text_area.mult:update(0)
            if vals.StatusText then 
                attention_text({
                    text = vals.mult,
                    scale = 0.8, 
                    hold = 1,
                    cover = G.hand_text_area.mult.parent,
                    cover_colour = mix_colours(G.C.MULT, col, 0.1),
                    emboss = 0.05,
                    align = 'cm',
                    cover_align = 'cl'
                })
            end
            if not G.TAROT_INTERRUPT then G.hand_text_area.mult:juice_up() end
        end
        if vals.handname and G.GAME.current_round.current_hand.handname ~= vals.handname then
            G.GAME.current_round.current_hand.handname = vals.handname
            if not config.nopulse then 
                G.hand_text_area.handname.config.object:pulse(0.2)
            end
        end
        if vals.chip_total then G.GAME.current_round.current_hand.chip_total = vals.chip_total;G.hand_text_area.chip_total.config.object:pulse(0.5) end
        if vals.level and G.GAME.current_round.current_hand.hand_level ~= ' '..localize('k_lvl')..tostring(vals.level) then
            if vals.level == '' then
                G.GAME.current_round.current_hand.hand_level = vals.level
            else
                G.GAME.current_round.current_hand.hand_level = ' '..localize('k_lvl')..tostring(vals.level)
                if type(vals.level) == 'number' then 
                    G.hand_text_area.hand_level.config.colour = G.C.HAND_LEVELS[math.min(vals.level, 7)]
                else
                    G.hand_text_area.hand_level.config.colour = G.C.HAND_LEVELS[1]
                end
                G.hand_text_area.hand_level:juice_up()
            end
        end
        if config.sound then play_sound(config.sound, config.pitch or 1, config.volume or 1) end
        return true
    end}))
end