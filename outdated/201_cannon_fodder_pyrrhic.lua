
-- This was one of the very first jokers I came up with and implemented, but I decided
-- to remove it because it's a bit too intricate, and there is no way to explain then
-- intricacies without a paragraph for the description

-- create global vars to keep track of Pyrrhic's value and gain
local igo = Game.init_game_object
function Game:init_game_object()
  local ret = igo(self)
  ret.pyrrhic_value = 1.0 
  return ret
end
local igo2 = Game.init_game_object
function Game:init_game_object()
  local ret = igo2(self)
  ret.pyrrhic_gain = 0.2
  return ret
end

-- Rare Joker
-- xmult, loses 0.1 every hand played and destroys joker to the right
-- buffs Pyrrhic, which cannon fodder can be sold to create
-- ess. Pyrrhic gets better and better the longer you hold onto cannon fodder
-- incentivizing risky play
SMODS.Joker {
  key = 'cannon_fodder',
  loc_txt = {
    name = 'Cannon Fodder',
    text = {
      "{X:mult,C:white}X#1#{} Mult",
      "Loses {C:mult}#2#{} Mult before every hand",
      "{C:red}Destroys{} {C:attention}Joker{} to the right after every hand",
      "Sell this card to create {C:attention}Pyrrhic{}"
    }
  },
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = false,
  perishable_compat = true,
  config = { extra = { Xmult = 1.0, 
                       mult_loss = 0.1 } },
  rarity = 3,
  atlas = 'VFAtlas',
  pos = { x = 0, y = 3 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    -- display pyrrhic's info in an infobox 
    info_queue[#info_queue + 1] = G.P_CENTERS.j_vfusion_pyrrhic
    return { vars = { card.ability.extra.Xmult,
                      card.ability.extra.mult_loss} }
  end,
  calculate = function(self, card, context)
    -- main calc during hand score
    if context.joker_main then
      return {
        Xmult_mod = card.ability.extra.Xmult,
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
      }
    end
    
    -- card sold trigger -> create the Pyrrhic joker
    if context.selling_self and #G.jokers.cards + G.GAME.joker_buffer <= G.jokers.config.card_limit and not context.retrigger_joker then
      local neg = nil
      -- if cannon fodder is negative, pyrrhic will be negative as well ;)
      if card.edition ~= nil and card.edition.type == 'negative' then
        neg = 'e_negative'
      end
      return SMODS.add_card({
        set = 'Joker', 
        area = G.jokers, 
        skip_materialize = false, 
        key = 'j_vfusion_pyrrhic',
        key_append = 'cannon', 
        no_edition = true,
        edition = neg
      })
    end
    
    -- before hand scored trigger -> lose mult
    if context.before and not context.blueprint then
      local msg = ''
      
      -- subtract 0.1 from cannon fodder's xmult, stops at 0
      -- weird logic is to avoid floating-point issues
      if card.ability.extra.Xmult < 0.2 then
        card.ability.extra.Xmult = 0
      end
      if card.ability.extra.Xmult > 0 then
        card.ability.extra.Xmult = card.ability.extra.Xmult - card.ability.extra.mult_loss
        msg = '-Mult!'
      end
      
      -- Update pyrrhic's value
      G.GAME.pyrrhic_value = G.GAME.pyrrhic_value + G.GAME.pyrrhic_gain
      
      -- every round the player keeps cannon fodder past 0.5x mult, pyrrhic gain is doubled
      -- (0.2 -> 0.4 -> 0.8 etc)
      -- done after other updates to only change display
      if card.ability.extra.Xmult < 0.6 then
        G.GAME.pyrrhic_gain = G.GAME.pyrrhic_gain + G.GAME.pyrrhic_gain
      end
      
      return {
        message = msg
      }
    end
    
    -- after hand scored trigger -> destroy joker to the right
    if context.after and not context.blueprint then
      local my_pos = nil
      for i = 1, #G.jokers.cards do
          if G.jokers.cards[i] == card then 
            my_pos = i
          end
      end
      if my_pos and G.jokers.cards[my_pos+1] and not self.getting_sliced and not G.jokers.cards[my_pos+1].ability.eternal then 
        local sliced_card = G.jokers.cards[my_pos+1]
        G.GAME.joker_buffer = G.GAME.joker_buffer - 1
        G.E_MANAGER:add_event(Event({func = function()
          play_sound('slice1', 0.96+math.random()*0.08)
          print(inspect(sliced_card))
          print(inspect(sliced_card.config))
          sliced_card:start_dissolve({HEX("ed2828")}, nil, 3)
          G.GAME.joker_buffer = 0
          G.GAME.pyrrhic_value = G.GAME.pyrrhic_value + G.GAME.pyrrhic_gain
          card:juice_up(0.8, 0.8)
          return true end
        }))
        card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult}}, colour = G.C.RED, no_juice = true})
      end
    end
  end
}

-- Rare Joker
-- xmult, gets better while cannon fodder is held, 
-- but doesn't change once cannon fodder is sold
-- potential to get very large xmult
SMODS.Joker {
  key = 'pyrrhic',
  loc_txt = {
    name = 'Pyrrhic',
    text = {
      "Gains {C:mult}+#2#{} Mult when",
      "Cannon Fodder loses Mult",
      "or destroys a Joker",
      "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
    }
  },
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  config = { extra = {} },
  rarity = 3,
  atlas = 'VFAtlas',
  pos = { x = 1, y = 3 },
  cost = 10,
  loc_vars = function(self, info_queue, card)
    return { vars = { G.GAME.pyrrhic_value,
                      G.GAME.pyrrhic_gain } }
  end,
  in_pool = function(self)
    -- Does not appear in the shop
    return false
  end,
  calculate = function(self, card, context)
    -- main calc during hand score
    -- xmult value won't change without a copy of cannon fodder
    -- so there isn't much to see here
    if context.joker_main then
      return {
        Xmult_mod = G.GAME.pyrrhic_value,
        message = localize { type = 'variable', key = 'a_xmult', vars = { G.GAME.pyrrhic_value } }
      }
    end
  end
}
