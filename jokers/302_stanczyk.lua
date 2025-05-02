
-- Legendary Joker
-- All cards in the shop are guaranteed to have an edition
SMODS.Joker {
  key = 'stan',
  unlocked = true,
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = false,
  config = { extra = {  } },
  rarity = 4,
  atlas = 'VFAtlas',
  pos = { x = 0, y = 1 },
  cost = 10,
  loc_vars = function(self, info_queue, card)
    return { vars = {  } }
  end,
  
  -- so the way the game determines if a card has an edition is weird,
  -- (see poll_edition() in common_events.lua)
  -- and a side effect of this is that 'guaranteeing' an edition
  -- means making edition rate really high. However, if the edition rate keeps
  -- increasing (like through multiple stanczyks), foil and holo become
  -- less common as polychrome becomes more common.
  add_to_deck = function(self, card, from_debuff)
    G.GAME.edition_rate = G.GAME.edition_rate + 25
  end,
  
  -- I also had to include a lovely patch to stop the vouchers from reseting the 
  -- edition rate
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.edition_rate = G.GAME.edition_rate - 25
  end
}
