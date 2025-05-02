
-- create global var to keep track of money added by jokers
-- lots of patches to base game to get this working
local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.dead_letters_buffer = {} 
  return ret
end

-- Common Joker
-- when another joker would payout money, add it to this joker's mult instead
SMODS.Joker {
  key = 'dead_letters',
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = { mult = 0 } },
  rarity = 1,
  atlas = 'VFAtlas',
  pos = { x = 3, y = 0 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  
  add_to_deck = function(self, card, from_debuff)
    -- even if player doesn't have this joker, values are still added to buffer during play
    -- reset buffer to stop the game from stealing money from you
    for i = 1, #G.GAME.dead_letters_buffer do G.GAME.dead_letters_buffer[i] = nil end
  end,
  
  calculate = function(self, card, context)
    -- main calc during hand score
    if context.joker_main and card.ability.extra.mult > 0 then
      return {
        mult = card.ability.extra.mult
      }
    end
    
    -- under any context (except if this is blueprint), if our buffer has
    -- values in it, create an event to steal them as mult
    -- sometimes the timing of the steal is a little weird
    if not context.blueprint and #G.GAME.dead_letters_buffer > 0 then
      local total = 0
      for i = 1, #G.GAME.dead_letters_buffer do total = total + G.GAME.dead_letters_buffer[i] end
      
      G.E_MANAGER:add_event(Event({ trigger = "after", delay = 0.75, func = function() 
        ease_dollars(total * -1, true)
        card.ability.extra.mult = card.ability.extra.mult + total
      return true end }))
      
      local str = '+' .. tostring(total)
      card_eval_status_text(
        card, 'extra', nil, nil, nil,
        {message = str, colour = G.C.MULT}
      )
      
      -- empty the buffer after events are created
      for i = 1, #G.GAME.dead_letters_buffer do G.GAME.dead_letters_buffer[i] = nil end
    end
    
    --[[ vanilla jokers that trigger this joker:
        Delayed Gratification - $2 per discard at end of round
        Business Card - played face cards 1 in 2 for $2
        Faceless joker - $5 if 3 face cards discard
        To-Do list - $4 when played hand = hand
        Cloud 9 - $1 for every 9 in deck - end of round
        Rocket - $1 end of round
        Reserved parking - face card in hand $1
        Mail in Rebate - Earn $5 for discard card
        Golden Joker - $4 at end of round
        Trading Card - discard earn $3
        Golden Ticket - played gold cards earn $4
        Rough Gem - played diamonds give $1
        Matador - $8 if played hand triggers boss blind
        Satellite - $1 at end of round per planet card
        
        Egg does not trigger this joker, it does not 'payout' at any point
        To the Moon does not trigger, it doesn't actually 'payout', only raises your intrest cap
    ]]
  end
}