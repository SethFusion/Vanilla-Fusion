
-- When starting this mod, I intentionally ignored reddit
-- and other places where Balatro mods were showcased,
-- mostly becasue I didn't want to be influenced by other's ideas.
-- This is a case where that didn't help me create something novel.
-- Apparently a 7 based joker related to lucky cards is
-- a fairly common idea, who would have guessed lol
-- Still had fun making it, and it probably needed to be nerfed anyway

-- Common Joker
-- every scored 7 creates a wheel of fortune or a magician card
SMODS.Joker {
  key = 'lucky_number',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { mult = 0 } },
  rarity = 1,
  atlas = 'VFAtlas',
  pos = { x = 4, y = 0 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,

  calculate = function(self, card, context)
    local played_card = context.other_card
    -- hand played trigger -> is card 7? -> create a wheel or magician
    if context.individual and context.cardarea == G.play and played_card:get_id() == 7 then
      local key = 'c_wheel_of_fortune'
      local num = pseudorandom('lucky_number')
      if num < (1/2) then
        key = 'c_magician'
      end 
      -- check that our consumable area is not full. if it is, we don't create a card
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        -- adding to this buffer represents the cards that will take up space after the events fire
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
          func = function()
            -- reset consumeable_buffer
            G.GAME.consumeable_buffer = 0
            SMODS.add_card({
              set = 'Tarot', 
              area = G.consumables, 
              skip_materialize = false,
              key = key, 
              no_edition = true
            })
          return true
          end
        }))
      end
    end
  end
}