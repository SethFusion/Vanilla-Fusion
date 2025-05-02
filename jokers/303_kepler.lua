
-- Legendary Joker
-- Every hand played creates a negative planet card of that hand
SMODS.Joker {
  key = 'kepler',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = {  } },
  rarity = 4,
  atlas = 'VFAtlas',
  pos = { x = 2, y = 1 },
  cost = 10,
  loc_vars = function(self, info_queue, card)
    return { vars = {  } }
  end,
  
  calculate = function(self, card, context)
    -- hand played trigger
    if context.before then
      -- default mercury in case we run into an issue
      local keystr = 'c_mercury'
      
      if context.scoring_name == 'Three of a Kind' then
        keystr = 'c_venus'
      elseif context.scoring_name == 'Full House' then
        keystr = 'c_earth'
      elseif context.scoring_name == 'Four of a Kind' then
        keystr = 'c_mars'
      elseif context.scoring_name == 'Flush' then
        keystr = 'c_jupiter'
      elseif context.scoring_name == 'Straight' then
        keystr = 'c_saturn'
      elseif context.scoring_name == 'Two Pair' then
        keystr = 'c_uranus'
      elseif context.scoring_name == 'Stright Flush' then
        keystr = 'c_neptune'
      elseif context.scoring_name == 'High Card' then
        keystr = 'c_pluto'
      elseif context.scoring_name == 'Five of a Kind' then
        keystr = 'c_planet_x'
      elseif context.scoring_name == 'Flush House' then
        keystr = 'c_ceres'
      elseif context.scoring_name == 'Flush Five' then
        keystr = 'c_eris'
      end
      
      G.E_MANAGER:add_event(Event({
        func = function()
          SMODS.add_card({
            set = 'Spectral', 
            area = G.consumeables, 
            skip_materialize = false, 
            key = keystr,
            key_append = 'kepler', 
            no_edition = true,
            edition = 'e_negative'
          })
        return true
        end
      }))
    end
  end
}
