
-- Spectral Card
-- Creates two random spectral cards
SMODS.Consumable({
  set = "Spectral",
  key = "apport",
  atlas = 'VFAtlas',
  pos = { x = 7, y = 3 },
  cost = 6,
  discovered = false,
  loc_vars = function(self, info_queue)
    return {}
  end,
  
  -- always usable 
  can_use = function(self, card)
    return true
  end,
  
  -- use function
  use = function(card, area, copier)
    -- spawn spectral cards
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
            key_append = 'apport', 
            no_edition = true
          })
        return true
        end
      }))
    end
    
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
            key_append = 'apport2', 
            no_edition = true
          })
        return true
        end
      }))
    end
  end
})
