
-- Decided to remove this for the same reason the first Cannon Fodder
-- was removed. There is no way to accurately explain the total outcome
-- of this joker without a paragraph, maybe multiple lol

-- Rare Joker
-- The next shop action you take will destroy this card and create 
-- random negative Joker related to the action taken 
-- (ex: Buying a Joker may create Abstract Joker)
SMODS.Joker {
  key = 'secret_code',
  unlocked = true,
  discovered = false,
  --no_collection = true,
  blueprint_compat = false,
  eternal_compat = false,
  perishable_compat = false,
  config = { extra = { } },
  rarity = 3,
  atlas = 'VFAtlas',
  pos = { x = 3, y = 3 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    -- display abtract Joker's info because it is listed in the desc
    info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    info_queue[#info_queue + 1] = G.P_CENTERS.j_flash
    return { vars = { } }
  end,
  calculate = function(self, card, context)
    -- blueprint cannot do anything here, so skip everything
    if not context.blueprint and (context.card ~= card) then
      local joker_spawn_list = {}
      local legendaries = { 'j_caino', 
                            'j_triboulet', 
                            'j_yorick', 
                            'j_chicot', 
                            'j_perkeo',
                            'j_vfusion_etteilla',
                            'j_vfusion_stan',
                            'j_vfusion_kepler',
                            'j_vfusion_bentov',
                            'j_vfusion_mischief' }
      
      if (context.buying_card or context.open_booster) then
        local bought = context.card
        local bought_name = bought.ability.name
        --print(bought.ability.name)
        --print(bought.ability.set)
        
        -- buying joker or bufoon booster
        if bought.ability.set == 'Joker' or (bought.ability.set == 'Booster' and string.find(bought.ability.name, 'Buffoon')) then
          -- abstract jocker
          -- swashbuckler
          table.insert(joker_spawn_list, 'j_abstract')
          table.insert(joker_spawn_list, 'j_swashbuckler')
          
        -- buying planet card directly from shop
        elseif bought.ability.set == 'Planet' then
          -- Mercury, Uranus = The Duo
          -- Venus, Earth = The Duo, The Trio
          -- Mars, Planet X = The Duo, The Trio, The Family
          -- Jupiter = The Tribe
          -- Saturn = The Order
          -- Neptune = The Tribe, The Order
          -- Pluto = Betting on Low
          -- Ceres = The Duo, The Trio, The Tribe
          -- Eris = The Duo, The Trio, The Family, The Tribe
          
          if bought_name == 'Mercury' or bought_name == 'Uranus' then
            table.insert(joker_spawn_list, 'j_duo')
          elseif bought_name == 'Venus' or bought_name == 'Earth' then
            table.insert(joker_spawn_list, 'j_duo')
            table.insert(joker_spawn_list, 'j_trio')
          elseif bought_name == 'Mars' or bought_name == 'Planet X' then
            table.insert(joker_spawn_list, 'j_duo')
            table.insert(joker_spawn_list, 'j_trio')
            table.insert(joker_spawn_list, 'j_family')
          elseif bought_name == 'Jupiter' then
            table.insert(joker_spawn_list, 'j_tribe')
          elseif bought_name == 'Saturn' then
            table.insert(joker_spawn_list, 'j_order')
          elseif bought_name == 'Neptune' then
            table.insert(joker_spawn_list, 'j_tribe')
            table.insert(joker_spawn_list, 'j_order')
          elseif bought_name == 'Pluto' then
            table.insert(joker_spawn_list, 'j_vfusion_betting_low')
          elseif bought_name == 'Ceres' then
            table.insert(joker_spawn_list, 'j_duo')
            table.insert(joker_spawn_list, 'j_trio')
            table.insert(joker_spawn_list, 'j_tribe')
          elseif bought_name == 'Eris' then
            table.insert(joker_spawn_list, 'j_duo')
            table.insert(joker_spawn_list, 'j_trio')
            table.insert(joker_spawn_list, 'j_family')
            table.insert(joker_spawn_list, 'j_tribe')
          else
            table.insert(joker_spawn_list, 'j_constellation')
          end
          
        -- buying planet booster
        elseif bought.ability.set == 'Booster' and string.find(bought.ability.name, 'Celestial') then
          --print (inspect(bought.ability))
          -- Astronomer
          -- Supernova
          -- Constellation
          -- Betting on Low
          table.insert(joker_spawn_list, 'j_astronomer')
          table.insert(joker_spawn_list, 'j_supernova')
          table.insert(joker_spawn_list, 'j_constellation')
          table.insert(joker_spawn_list, 'j_vfusion_betting_low')
          
        -- buying tarot directly from shop
        elseif bought.ability.set == 'Tarot' then
          --print (bought.ability.name)
          -- the fool = joker
          -- magician = lucky cat
          -- high priestess = space joker, satellite
          -- empress = shoot the moon
          -- emperor = baron
          -- hierophant = hiker
          -- lovers = smeared joker
          -- chariot = steel joker
          -- justice = jack of speed, glass joker
          -- hermit = boostraps, bull
          -- wheel of fortune = opps all 6s
          -- strength = raised fist
          -- hanged man = erosion
          -- death = DNA
          -- temperance = swashbuckler, egg, gift card
          -- devil = midas mask, golden ticket
          -- the tower = stone joker, marble joker
          -- star = greedy, Rough Gem
          -- sun = lusty, Bloodstone
          -- world = gluttonous, Onyx Agate
          -- moon = wrathful, Arrowhead
          -- judgement = cermonial dagger, madness, riff-raff
          
          if bought_name == 'The Fool' then
            table.insert(joker_spawn_list, 'j_joker')
          elseif bought_name == 'The Magician' then
            table.insert(joker_spawn_list, 'j_lucky_cat')
          elseif bought_name == 'The High Priestess' then
            table.insert(joker_spawn_list, 'j_space')
            table.insert(joker_spawn_list, 'j_satellite')
          elseif bought_name == 'The Empress' then
            table.insert(joker_spawn_list, 'j_shoot_the_moon')
          elseif bought_name == 'The Emperor' then
            table.insert(joker_spawn_list, 'j_baron')
          elseif bought_name == 'The Hierophant' then
            table.insert(joker_spawn_list, 'j_hiker')
          elseif bought_name == 'The Lovers' then
            table.insert(joker_spawn_list, 'j_smeared')
          elseif bought_name == 'The Chariot' then
            table.insert(joker_spawn_list, 'j_steel_joker')
          elseif bought_name == 'Justice' then
            table.insert(joker_spawn_list, 'j_glass')
            table.insert(joker_spawn_list, 'j_vfusion_jack_of_speed')
          elseif bought_name == 'The Hermit' then
            table.insert(joker_spawn_list, 'j_bootstraps')
            table.insert(joker_spawn_list, 'j_bull')
          elseif bought_name == 'The Wheel of Fortune' then
            local num = pseudorandom('joker_wheel')
              if num < (G.GAME.probabilities.normal / 4) then
                for _,v in ipairs(legendaries) do
                  table.insert(joker_spawn_list, v)
                end
              else
                table.insert(joker_spawn_list, 'j_oops')
              end
          elseif bought_name == 'Strength' then
            table.insert(joker_spawn_list, 'j_raised_fist')
          elseif bought_name == 'The Hanged Man' then
            table.insert(joker_spawn_list, 'j_erosion')
          elseif bought_name == 'Death' then
            table.insert(joker_spawn_list, 'j_dna')
          elseif bought_name == 'Temperance' then
            table.insert(joker_spawn_list, 'j_swashbuckler')
            table.insert(joker_spawn_list, 'j_egg')
            table.insert(joker_spawn_list, 'j_gift')
          elseif bought_name == 'The Devil' then
            table.insert(joker_spawn_list, 'j_midas_mask')
            table.insert(joker_spawn_list, 'j_ticket')
          elseif bought_name == 'The Tower' then
            table.insert(joker_spawn_list, 'j_stone')
            table.insert(joker_spawn_list, 'j_marble')
          elseif bought_name == 'The Star' then
            table.insert(joker_spawn_list, 'j_greedy_joker')
            table.insert(joker_spawn_list, 'j_rough_gem')
          elseif bought_name == 'The Sun' then
            table.insert(joker_spawn_list, 'j_lusty_joker')
            table.insert(joker_spawn_list, 'j_bloodstone')
          elseif bought_name == 'The World' then
            table.insert(joker_spawn_list, 'j_wrathful_joker')
            table.insert(joker_spawn_list, 'j_arrowhead')
          elseif bought_name == 'The Moon' then
            table.insert(joker_spawn_list, 'j_gluttenous_joker')
            table.insert(joker_spawn_list, 'j_onyx_agate')
          elseif bought_name == 'Judgement' then
            table.insert(joker_spawn_list, 'j_ceremonial')
            table.insert(joker_spawn_list, 'j_madness')
            table.insert(joker_spawn_list, 'j_riff_raff')
          else
            table.insert(joker_spawn_list, 'j_fortune_teller')
          end
        
        -- buying arcana booster
        elseif (bought.ability.set == 'Booster' and string.find(bought.ability.name, 'Arcana')) then
          --print (inspect(bought.ability))
          -- cartomancer
          -- hallucination
          -- fortune teller
          -- vagabond
          table.insert(joker_spawn_list, 'j_cartomancer')
          table.insert(joker_spawn_list, 'j_hallucination')
          table.insert(joker_spawn_list, 'j_fortune_teller')
          table.insert(joker_spawn_list, 'j_vagabond')
          
        -- buying spectral directly from shop
        elseif bought.ability.set == 'Spectral' then
          -- familiar = Scary Face, Photograph, Smily Face, Sock and Buskin
          -- grim = Scholar, Fibonacci
          -- incantation = Ride the Bus, raised fist, even steven, odd todd
          -- talisman, deja vu, trance, medium = certificate
          -- aura, dredge = mr bones, drunkard
          -- wraith = vagabond, 
          -- sigil = the tribe
          -- ouija = the order, the idol
          -- ectoplasm = juggler
          -- immolate = erosion
          -- ankh = blueprint, brainstorm
          -- hex = joker stencil
          -- cryptid = DNA
          -- soul = any legendary joker
          -- black hole = wormhole
          
          if bought_name == 'Familiar' then
            table.insert(joker_spawn_list, 'j_scary_face')
            table.insert(joker_spawn_list, 'j_photograph')
            table.insert(joker_spawn_list, 'j_smiley')
            table.insert(joker_spawn_list, 'j_sock_and_buskin')
          elseif bought_name == 'Grim' then
            table.insert(joker_spawn_list, 'j_scholar')
            table.insert(joker_spawn_list, 'j_fibonacci')
          elseif bought_name == 'Incantation' then
            table.insert(joker_spawn_list, 'j_ride_the_bus')
            table.insert(joker_spawn_list, 'j_raised_fist')
            table.insert(joker_spawn_list, 'j_even_steven')
            table.insert(joker_spawn_list, 'j_odd_todd')
          elseif bought_name == 'Talisman' or bought_name == 'Deja Vu' or bought_name == 'Trance' or bought_name == 'Medium' then
            table.insert(joker_spawn_list, 'j_certificate')
          elseif bought_name == 'Aura' or bought_name == 'Dredge' then
            table.insert(joker_spawn_list, 'j_mr_bones')
            table.insert(joker_spawn_list, 'j_drunkard')
          elseif bought_name == 'Sigil' then
            table.insert(joker_spawn_list, 'j_tribe')
          elseif bought_name == 'Ouija' then
            table.insert(joker_spawn_list, 'j_order')
            table.insert(joker_spawn_list, 'j_idol')
          elseif bought_name == 'Ectoplasm' then
            table.insert(joker_spawn_list, 'j_juggler')
          elseif bought_name == 'Immolate' then
            table.insert(joker_spawn_list, 'j_erosion')
          elseif bought_name == 'Ankh' then
            table.insert(joker_spawn_list, 'j_blueprint')
            table.insert(joker_spawn_list, 'j_brainstorm')
          elseif bought_name == 'Hex' then
            table.insert(joker_spawn_list, 'j_stencil')
          elseif bought_name == 'Cryptid' then
            table.insert(joker_spawn_list, 'j_dna')
          elseif bought_name == 'Soul' then
            for _,v in ipairs(legendaries) do
              table.insert(joker_spawn_list, v)
            end
          elseif bought_name == 'Black Hole' then
            table.insert(joker_spawn_list, 'j_vfusion_worm_hole')
          else
            table.insert(joker_spawn_list, 'j_vfusion_worm_hole')
          end
        
        -- buying spectral booster
        elseif (bought.ability.set == 'Booster' and string.find(bought.ability.name, 'Spectral')) then
          -- sixth sense
          -- worm hole
          -- minefield
          table.insert(joker_spawn_list, 'j_sixth_sense')
          table.insert(joker_spawn_list, 'j_vfusion_worm_hole')
          table.insert(joker_spawn_list, 'j_vfusion_minefield')
          
        -- buying a voucher
        elseif bought.ability.set == 'Voucher' then
          -- diet cola
          -- divination
          -- horoscope
          table.insert(joker_spawn_list, 'j_diet_cola')
          table.insert(joker_spawn_list, 'j_vfusion_divination')
          table.insert(joker_spawn_list, 'j_vfusion_horoscope')
        
        -- buying standard booster
        elseif (bought.ability.set == 'Booster' and string.find(bought.ability.name, 'Standard')) then
          -- driver's license
          -- hologram 
          -- smeared joker
          table.insert(joker_spawn_list, 'j_drivers_license')
          table.insert(joker_spawn_list, 'j_hologram')
          table.insert(joker_spawn_list, 'j_smeared')
          
        -- buying playing card direct from shop
        elseif bought.ability.set == 'Default' then
          -- diamond = greedy, Rough Gem
          -- heart = lusty, Bloodstone
          -- spade = wrathful, Arrowhead
          -- club = gluttonous, Onyx Agate, seeing double
          -- 2 = hack, wee joker, fibonacci
          -- 3 = hack, fibonacci, 3's a crowd
          -- 4 = hack, fore!, walkie-talkie
          -- 5 = hack, midway, fibonacci
          -- 6 = sixth sense
          -- 7 = jackpot
          -- 8 = 8 ball, fibonacci
          -- 9 = cloud nine
          -- 10 = countdown, walkie-talkie
          -- j = sock and buskin, hit the road, jack of speed
          -- q = sock and buskin, shoot the moon
          -- k = sock and buskin, baron
          -- a = scholar, fibonacci
          
          if bought.base.suit == 'Spades' then
            table.insert(joker_spawn_list, 'j_wrathful_joker')
            table.insert(joker_spawn_list, 'j_arrowhead')
          elseif bought.base.suit == 'Clubs' then
            table.insert(joker_spawn_list, 'j_gluttenous_joker')
            table.insert(joker_spawn_list, 'j_onyx_agate')
            table.insert(joker_spawn_list, 'j_seeing_double')
          elseif bought.base.suit == 'Diamonds' then
            table.insert(joker_spawn_list, 'j_greedy_joker')
            table.insert(joker_spawn_list, 'j_rough_gem')
          elseif bought.base.suit == 'Hearts' then
            table.insert(joker_spawn_list, 'j_lusty_joker')
            table.insert(joker_spawn_list, 'j_bloodstone')
          end
          
          if bought.base.id == 2 then
            table.insert(joker_spawn_list, 'j_hack')
            table.insert(joker_spawn_list, 'j_wee')
            table.insert(joker_spawn_list, 'j_fibonacci')
          elseif bought.base.id == 3 then
            table.insert(joker_spawn_list, 'j_hack')
            table.insert(joker_spawn_list, 'j_fibonacci')
            table.insert(joker_spawn_list, 'j_vfusion_crowd')
          elseif bought.base.id == 4 then
            table.insert(joker_spawn_list, 'j_hack')
            table.insert(joker_spawn_list, 'j_vfusion_fore')
            table.insert(joker_spawn_list, 'j_walkie_talkie')
          elseif bought.base.id == 5 then
            table.insert(joker_spawn_list, 'j_hack')
            table.insert(joker_spawn_list, 'j_fibonacci')
            table.insert(joker_spawn_list, 'j_vfusion_midway')
          elseif bought.base.id == 6 then
            table.insert(joker_spawn_list, 'j_sixth_sense')
          elseif bought.base.id == 7 then
            table.insert(joker_spawn_list, 'j_vfusion_jackpot')
          elseif bought.base.id == 8 then
            table.insert(joker_spawn_list, 'j_fibonacci')
            table.insert(joker_spawn_list, 'j_8_ball')
          elseif bought.base.id == 9 then
            table.insert(joker_spawn_list, 'j_cloud_9')
          elseif bought.base.id == 10 then
            table.insert(joker_spawn_list, 'j_vfusion_countdown')
            table.insert(joker_spawn_list, 'j_walkie_talkie')
          elseif bought.base.id == 11 then
            table.insert(joker_spawn_list, 'j_sock_and_buskin')
            table.insert(joker_spawn_list, 'j_hit_the_road')
            table.insert(joker_spawn_list, 'j_vfusion_jack_of_speed')
          elseif bought.base.id == 12 then
            table.insert(joker_spawn_list, 'j_sock_and_buskin')
            table.insert(joker_spawn_list, 'j_shoot_the_moon')
          elseif bought.base.id == 13 then
            table.insert(joker_spawn_list, 'j_sock_and_buskin')
            table.insert(joker_spawn_list, 'j_baron')
          elseif bought.base.id == 14 then
            table.insert(joker_spawn_list, 'j_scholar')
            table.insert(joker_spawn_list, 'j_fibonacci')
          end
        end
      end
      
      if context.reroll_shop then
        -- flash card
        -- splash
        -- chaos the clown
        table.insert(joker_spawn_list, 'j_flash')
        table.insert(joker_spawn_list, 'j_splash')
        table.insert(joker_spawn_list, 'j_chaos')
      end
      
      if context.selling_card then
        -- campfire
        -- diet cola
        -- invisible Joker
        table.insert(joker_spawn_list, 'j_campfire')
        table.insert(joker_spawn_list, 'j_diet_cola')
        table.insert(joker_spawn_list, 'j_invisible')
      end
      
      if context.skipping_booster then
        -- any legendary joker
        for _,v in ipairs(legendaries) do
          table.insert(joker_spawn_list, v)
        end
      end
      
      -- if table is not empty by this point, destroy joker and create a random one from table
      if #joker_spawn_list ~= 0 then
        card.ability.extra.delete = true
        
        -- if player has more than one secret code for some reason,
        -- they all need to be destroyed
        local secret_code_pos = {}
        for i = 1, #G.jokers.cards do
          if G.jokers.cards[i].config.center_key == self.name then 
            table.insert(secret_code_pos, i)
          end
        end
        for i = 1, #secret_code_pos do
          local sliced_card = G.jokers.cards[secret_code_pos[i]]
          G.E_MANAGER:add_event(Event({func = function()
            sliced_card:start_dissolve()
            return true end
          }))
        end
        
        local num = math.floor(pseudorandom('secret') * 100)
        local index = math.fmod((num), #joker_spawn_list) + 1
        
        return SMODS.add_card({
          set = 'Joker', 
          area = G.jokers, 
          skip_materialize = false, 
          key = joker_spawn_list[index],
          key_append = 'secret', 
          no_edition = true,
          edition = 'e_negative'
        })
      end
    end
  end
}