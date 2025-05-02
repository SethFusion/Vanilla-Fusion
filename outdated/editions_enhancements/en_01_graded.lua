
-- Graded
-- Chips are doubled for this card when scored
SMODS.Enhancement ({
  key = "graded",
  loc_txt = {
    name = "Graded",
    label = "Graded",
    text = {
      "Chips are doubled for this card when scored"
    }
  },
  atlas = 'VFEditionAtlas',
  pos = { x = 1, y = 1 },
  replace_base_card = true, 
  config = {  },
  weight = 5,
  get_weight = function(self)
    return self.weight
  end,
  loc_vars = function(self)
    return { vars = {  } }
  end,
  
  calculate = function(self, card, context, effect)
    if context.cardarea == G.play and not context.repetition then
      effect.bonus_chips = card.rank * 2
    end
  end
})

SMODS.Consumable ({
  set = 'Tarot',
  key = 'juggler',
  loc_txt = {
    name = "The Juggler",
    text = {
      "Enchance two cards with Graded"
    }
  },
  atlas = 'VFTarotAtlas',
  pos = { x = 0, y = 0 },
  cost = 3,
  config = {  },
  loc_vars = function(self)
    return { vars = {  } }
  end,
  
  -- Checks selected cards to make sure they meet criteria for use
  -- Must have 1 0r 2 cards selected with no enhancement
  can_use = function(self, card)
    print(inspect(card))
    if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or
      any_state then
      if #G.hand.highlighted <= 2 and (not SMODS.get_enhancements(G.hand.highlighted[1], true) or not SMODS.get_enhancements(G.hand.highlighted[2], true)) then
        return true
      end
    end
  end,
  
  -- use function
  use = function(card, area, copier)
    if not SMODS.get_enhancements(card, true) then 
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          local selected = card
          poll_enhancement({key = 'graded', guaranteed = true, options = {keys = {'e_vfusion_graded'}}})

          G.hand:unhighlight_all()
          return true
        end
      }))
    end
  end
})
