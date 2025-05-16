return {
  descriptions = {
    Joker = {
      -- Common
      j_vfusion_jimbos_watch = {
        name = 'Jimbo\'s Timer',
        text = {
          "Gains {C:chips}+#3#{} Chips every round.",
          "At {C:chips}60{}, converts into {C:mult}+#4#{} Mult",
          "{C:inactive}(Currently {C:chips}+#1#{C:inactive} and {C:mult}+#2#{C:inactive})"
        }
      },
      j_vfusion_betting_low = {
        name = 'Betting on Low',
        text = {
          "{C:green}#1# in #2#{} chance to",
          " create {C:planet}Pluto{}, {C:planet}Mercury{},",
          "or {C:planet}Uranus{} every hand",
          "{C:inactive}(Must have room)"
        }
      },
      j_vfusion_subvention = {
        name = 'Subvention',
        text = {
          "Earn {C:money}$1{} for each",
          "used {C:attention}Tag{} at",
          "end of round",
          "{C:inactive}(Currently {C:money}$#1#{}{C:inactive})",
        }
      },
      j_vfusion_dead_letters = {
        name = 'Dead Letters',
        text = {
          "When another {C:attention}Joker{} would earn {C:money}${},",
          "add it to this {C:attention}Joker's{} Mult instead",
          "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
        }
      },
      j_vfusion_jackpot = {
        name = 'Jackpot',
        text = {
          "Shop size is temporarily",
          "increased by the number of",
          "{C:attention}7's{} in your winning hand"
        }
      },
      j_vfusion_fore = {
        name = 'Fore!',
        text = {
          "Every scored {C:attention}4{} is",
          "{C:alert}destroyed{} and earns {C:money}$10{}"
        }
      },
      j_vfusion_multiverse = {
        name = 'Multiverse',
        text = {
          "If a {C:green}probablity{} fails it's first",
          "check, it is {C:attention}rerolled{} once"
        }
      },
      j_vfusion_layaway = {
        name = 'Layaway',
        text = {
          "The first item bought in the",
          "shop isn't paid for until",
          "the end of the next round",
          "{C:inactive}(#1#)"
        }
      },
      j_vfusion_divination = {
        name = 'Divination',
        text = {
          "If final {C:attention}poker hand{} of",
          "round is a {C:attention}#1#{},",
          "create a {C:purple}Charm{} tag.",
          "Hand changes at end of round"
        }
      },
      j_vfusion_horoscope = {
        name = 'Horoscope',
        text = {
          "If final {C:attention}poker hand{} of",
          "round is a {C:attention}#1#{},",
          "create an {C:blue}Orbital{} tag",
          "for that hand",
          "Hand changes at end of round"
        }
      },
      j_vfusion_art = {
        name = 'Art of the Deal',
        text = {
          "{C:attention}Jokers{} and {C:attention}Consumables{} starting",
          "sell price is the same as their buy price",
          "{C:inactive}(This card excluded)"
        }
      },
      -- Uncommon
      j_vfusion_one_trick_pony = {
        name = 'One Trick Pony',
        text = {
          "Earn {C:money}$#2#{} at end of each",
          "round per {C:attention}consecutive{}",
          "{C:attention}High Card{} played",
          "{C:inactive}(Currently {C:money}$#1#{C:inactive})"
        }
      },
      j_vfusion_worm_hole = {
        name = 'Worm Hole',
        text = {
          "When a {C:spectral}Spectral{} card is used,",
          "create a {C:dark_edition}negative{} {C:spectral}Black Hole{}",
          "{C:inactive}({C:spectral}Black Hole{}{C:inactive} excluded)"
        }
      },
      j_vfusion_jack_of_speed = {
        name = 'Jack of Speed',
        text = {
          "After hand is played:",
          "Every scored {C:attention}playing card{} has a",
          "{C:green}#1# in #2#{} chance to become a {C:attention}Jack{}",
          "Every scored {C:attention}Jack{} has a",
          "{C:green}#1# in #2#{} chance to become {C:attention}Glass{}"
        }
      },
      j_vfusion_countdown = {
        name = 'Countdown',
        text = {
          "Every scoring {C:attention}10{} reduces",
          "countdown by {C:attention}1{}. Gain {X:mult,C:white}X#1#{} Mult",
          "when it reaches {C:attention}0{}. {C:inactive}[#3#]{}",
          "{C:inactive}(Currently {X:mult,C:white}X#2#{}{C:inactive} Mult)"
        }
      },
      j_vfusion_oxbow = {
        name = 'Oxbow',
        text = {
          "{C:chips}+25{} Chips for every {C:gold}$1{}",
          "you are under {C:gold}$0{}",
          "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
        }
      },
      j_vfusion_staying_down = {
        name = 'Staying Down',
        text = {
          "{C:mult}+8{} Mult for every {C:gold}$1{}",
          "you are under {C:gold}$0{}",
          "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
        }
      },
      j_vfusion_high_roller = {
        name = 'High Roller',
        text = {
          "{X:mult,C:white}X1{} Mult for every",
          "{C:gold}$100{} you have",
          "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
        }
      },
      j_vfusion_midway = {
        name = 'Midway',
        text = {
          "Every scored {C:attention}5{} swaps",
          "Chips and Mult"
        }
      },
      j_vfusion_kismet = {
        name = 'Kismet',
        text = {
          "{C:dark_edition}+1{} Joker Slot after",
          "defeating Boss Blind.",
          "No cards can be",
          "{C:attention}sold{} or {C:red}destroyed{}"
        }
      },
      -- Rare
      j_vfusion_minefield = {
        name = 'Minefield',
        text = {
          "{C:green}#1# in #2#{} chance to {E:1,C:red}downgrade{}",
          "level of most played {C:attention}poker hand{}",
          "and create a {C:spectral}Spectral{} card",
          "after hand is scored",
          "{C:inactive}(Must have room)"
        }
      },
      j_vfusion_cannon = {
        name = 'Cannon Fodder',
        text = {
          "{C:red}Destroy{} all scored cards",
          "after hand played and earn",
          "{X:mult,C:white}X#1#{} mult per card destroyed",
          "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
        }
      },
      j_vfusion_third_time = {
        name = 'Third Time',
        text = {
          "Every {C:attention}third{} scoring",
          "{C:attention}3{} gives {X:mult,C:white}X#1#{} Mult",
          "{C:inactive}#2#"
        }
      },
      j_vfusion_latency = {
        name = 'Latency',
        text = {
          "Scored cards are temporarily",
          "{C:attention}removed{} from deck",
          "When selecting the {C:attention}Boss Blind{},",
          "removed cards are {C:attention}returned{} and",
          "drawn to your hand"
        }
      },
      j_vfusion_benediction = {
        name = 'Benediction',
        text = {
          "Every scored playing card has a:",
          "{C:green}#1# in #2#{} chance to gain an {C:attention}enhancement{}",
          "{C:green}#1# in #3#{} chance to gain an {C:attention}edition{}"
        }
      },
      -- Legendary
      j_vfusion_etteilla = {
        name = 'Etteilla',
        text = {
          "Using a {C:tarot}Tarot{} card",
          "creates a single {C:attention}copy{}",
          "of that card"
        },
        unlock={
          "{E:1,s:1.3}?????",
        }
      },
      j_vfusion_stan = {
        name = 'Stańczyk',
        text = {
          "All cards in the shop are",
          "guaranteed to have an {C:attention}edition{}"
        },
        unlock={
          "{E:1,s:1.3}?????",
        }
      },
      j_vfusion_kepler = {
        name = 'Kepler',
        text = {
          "Playing cards with a {C:planet}Blue Seal{}",
          "gain {X:mult,C:white}0.5X{} held-in-hand Mult",
          "when their {C:planet}Blue Seal{} triggers"
        },
        unlock={
          "{E:1,s:1.3}?????",
        }
      },
      j_vfusion_bentov = {
        name = 'Bentov',
        text = {
          "Current {C:attention}Jokers{} with no {C:attention}edition{} become",
          "{C:dark_edition}negative{} when this card is sold"
        },
        unlock={
          "{E:1,s:1.3}?????",
        }
      },
      j_vfusion_mischief = {
        name = 'Mischief',
        text = {
          "Removes {C:attention}edition{} from {C:attention}Jokers{} and {C:attention}playing cards{}",
          "when blind is selected. Gains {X:mult,C:white}X#1#{} Mult",
          "for each {C:attention}edition{} removed {C:inactive}({C:dark_edition}negative {C:inactive}excluded){}",
          "{C:inactive}(Currently {X:mult,C:white}X#2#{}{C:inactive} Mult)"
        },
        unlock={
          "{E:1,s:1.3}?????",
        }
      }
    },
    Other = {
      vfusion_buffed={
        name="Buffed",
        text={
          "This card has been",
          "given {C:attention}permanent{} buffs",
        }
      }
    },
    Spectral={
      c_vfusion_dredge={
        name='Dredge',
        text={
          "Remove {C:attention}Edition{} from selected",
          "{C:attention}Joker{} or {C:attention}Playing Card{} and",
          "replace it with a {C:dark_edition}random{} {C:attention}Edition{}",
          "{C:inactive}({C:dark_edition}negative {C:inactive}excluded)"
        }
      },
      c_vfusion_epoch={
        name='Epoch',
        text={
          "Select an {C:attention}enhanced card{}.",
          " Add it's enhancement",
          "as a {C:attention}permanent bonus{}",
          " and remove enhancement",
          "{C:inactive}(Wild and Probabilities excluded){}"
        }
      },
      c_vfusion_apport={
        name='Apport',
        text={
          "Creates up to {C:attention}2",
          "random {C:spectral}Spectral{} cards",
          "{C:inactive}(Must have room)"
        }
      }
    }
  },
  misc={
    labels={
      vfusion_buffed='Buffed'
    },
    v_dictionary={
      shareholder_interest="#1#x Blind Score = $#2#"
    }
  }
}
