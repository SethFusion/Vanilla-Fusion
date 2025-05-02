
-- Unommon Joker
-- Any time a spectral card is used, create a negative Black Hole (Black Hole excluded)
SMODS.Joker {
  key = 'worm_hole',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { } },
  rarity = 2,
  atlas = 'VFAtlas',
  pos = { x = 1, y = 2 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = {
      key = 'e_negative_consumable', 
      set = 'Edition', 
      config = {extra = 1}
    }
    info_queue[#info_queue + 1] = G.P_CENTERS.c_black_hole
    return { vars = { } }
  end,
  calculate = function(self, card, context)
    -- use consumable trigger
    -- if the consumable is a spectral card that isn't Black Hole, create a Black Hole
    if context.using_consumeable and context.consumeable.ability.set == 'Spectral' and context.consumeable.ability.name ~= 'Black Hole' then
      G.E_MANAGER:add_event(Event({
        func = function()
          SMODS.add_card({
            set = 'Spectral', 
            area = G.consumeables, 
            skip_materialize = false, 
            key = 'c_black_hole',
            key_append = 'wormhole', 
            no_edition = true,
            edition = 'e_negative'
          })
        return true
        end
      }))
    end
  end
}
