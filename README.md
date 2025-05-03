# Welcome to Vanilla Fusion!
## What is this?

A vanilla-esque mod for Balatro currently featuring 30 jokers and 1 spectral card.

## Why is this?

I started making this mod on a whim when I learned you could access Balatro's source code with almost no effort. Unfortunately, I fell in love with LUA (I've never touched it before) and Balatro's source code, so I decided to just keep adding stuff as long as I was having fun! 

## How is this?

When I started VF, I didn't know there were many Balatro mods out there. I had only ever heard of Cryptid, and that wasn't my speed. Still, I decided to ignore other mods and ideas from Reddit, hoping to come up with my own unique ideas that others weren't implementing. The only resources I used were the SMODS wiki, occasional Discord questions, and even rarer peeks at Cryptid source code. I _hope_ this has led to some ideas the community has not seen before. If not, oh well. I still had fun.

I will say I did quite a bit of lovely patching with this mods, so I'm not sure how well it will play with other mods.

Let me also say I am not an artist, and none of these jokers have art yet :(

## What's _in_ this?

Here's a rundown of everything currently implemented
#### Common Jokers
* [x] Jimbo's Timer - Gains 15 chips every round. At 60, converts into 12 Mult
* [x] Betting on Low - 1 in 3 chance to create a Planet card for High Card, Pair, or Two Pair every hand
* [x] Dead Letters - when another joker would payout money, add it to this joker's mult instead
* [x] Fore! - Scored 4s are destroyed and give 10 dollars
* [x] Multiverse - If a probability fails its first check, reroll it once
* [x] Art of the Deal - Cards sell for their buy price (more or less)
* [x] Horoscope - beating the blind by playing a (hand) creates Orbital tag - changes every round 
* [x] Divination - beating the blind by playing a (hand) creates Charm tag - changes every round 
* [x] Subvention - Earn $1 at end of round per tag used this run
* [x] Layaway - The first shop item you buy is free, but you will be charged at the end of the next round (can go into debt)
#### Uncommon Jokers
* [x] Oxbow - +25 Chips for every $1 you have under $0
* [x] Staying Down - +8 Mult for every $1 you have under $0
* [x] One Trick Pony - Earn $1 at the end of round per consecutive High Card played
* [x] High Roller - Gain x1 Mult for every $100 you have (100 is x2 mult, 200 is x3 mult, etc.)
* [x] Worm Hole - Any time a Spectral card is used, create a negative Black Hole card (Black Hole excluded)
* [x] Jack of Speed - Every played card has a 1 in 4 chance to become a Jack. Played jacks have a 1 in 4 chance to become glass
* [x] Countdown - Every scored 10 reduces countdown by 1. Gain 0.5x mult when it reaches 0
* [x] Midway - Scored 5s swap current chips and mult
* [x] Jackpot - shop size increases by the number of 7s in the winning hand
* [x] Kismet - Gain 1 joker slot after beating boss blind, no Jokers can be destroyed or sold
#### Rare Jokers
* [x] Minefield - 1 in 8 chance to de-level most played hand and create a spectral card
* [x] Cannon Fodder - destroy all played cards after hand and earn 0.2x mult per card destroyed
* [x] Third Time - Every third scoring 3 gives x3 mult
* [x] Latency - Played cards are temporarily removed from deck. When selecting the boss blind, they are returned and drawn to your hand
* [x] Benediction - scored cards have a 1 in 5 chance to gain an enhancement and a 1 in 20 chance to gain an edition
#### Legendary Jokers
* [x] Stańczyk - All cards in the shop are guaranteed to have an edition
* [x] Etteilla - Gain 0.2x mult for every tarot card used this run
* [x] Kepler - Every hand played creates a negative planet card of that hand
* [x] Bentov - all editionless jokers become negative when this card is sold
* [x] Mischief - Removes editions from all jokers and cards when blind is selected. Gains x2 Mult for every edition removed. (Negative excluded)
#### Spectral Cards
* [X] Dredge - Remove edition from selected joker or card, replace with a random edition

## What's next?

I would like to get feedback and testing for these cards and, if they pass the small test, complete them with art. I'm not sure who to reach out to for art, if you are interested or know someone who might be interested, please message me!

I am also open to suggestions for tweaks, changes, or completely new ideas. That being said, I'm only interested in feedback relating to _how fun_ these jokers are. Basically, are they fun enough to be in the game at all? Balancing things, like "this card is too powerful or not powerful enough," I'm not too concerned about. I intentionally made some of them rather good, and others rather meh because that's how vanilla works. Some cards are always on the 'take' list, some are circumstantial, and some are almost always a pass unless in a really specific scenario. Some are better toward the beginning of the game to help you get on your feet, others are only good near the boss blind. You get the idea, and I think that's how it _should_ be. :) 
