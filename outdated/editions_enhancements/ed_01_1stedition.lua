
-- 1st Edition
-- Earn $5 when scored
SMODS.Shader({ key = 'fluorescent', path = 'fluorescent.fs' })
SMODS.Edition({
  key = "1st_edition",
  loc_txt = {
    name = "1st Edition",
    label = "1st Edition",
    text = {
      "{C:money}+$#1#{}"
    }
  },
  discovered = true,
  unlocked = true,
  shader = 'fluorescent',
  config = { p_dollars = 3 },
  in_shop = true,
  weight = 10,
  get_weight = function(self)
    return G.GAME.edition_rate * self.weight
  end,
  extra_cost = 5,
  apply_to_float = true,
  loc_vars = function(self)
    return { vars = { self.config.p_dollars } }
  end
})
