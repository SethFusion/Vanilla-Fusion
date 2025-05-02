
-- Platinum
-- 2x Mult played or in hand
SMODS.Shader({ key = 'fluorescent', path = 'fluorescent.fs' })
SMODS.Edition({
  key = "platinum",
  loc_txt = {
    name = "Platinum",
    label = "Platinum",
    text = {
      "{X:mult,C:white}X#1#{} Mult"
    }
  },
  discovered = true,
  unlocked = true,
  shader = 'fluorescent',
  config = { x_mult = 2 },
  in_shop = true, --  must be in shop to apply to some pools
  weight = 1,
  get_weight = function(self)
    return G.GAME.edition_rate * self.weight
  end,
  extra_cost = 10,
  apply_to_float = true,
  badge_colour = G.C.DARK_EDITION,
  loc_vars = function(self)
    return { vars = { self.config.x_mult } }
  end
})
