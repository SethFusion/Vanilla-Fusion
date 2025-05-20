SMODS.Atlas {
  key = "VFAtlas",
  path = "VFJokers.png",
  px = 71,
  py = 95,
}

SMODS.Atlas {
  key = "VFStickers",
  path = "VFStickers.png",
  px = 71,
  py = 95,
}

--SMODS.Atlas {
--  key = "VFEditionAtlas",
--  path = "VFEnhance.png",
--  px = 71,
--  py = 95,
--}

--SMODS.Atlas {
--  key = "VFTarotAtlas",
--  path = "VFTarot.png",
--  px = 71,
--  py = 95,
--}

local jokers_dir = 'jokers'
local editions_dir = 'editions_enhancements'
local consumables_dir = 'consumables'

for _, filename in pairs(NFS.getDirectoryItems(SMODS.current_mod.path .. jokers_dir)) do
  local file, exception = SMODS.load_file(jokers_dir .. "/" .. filename)
  if exception then
    error(exception)
  end
  file()
end

--for _, filename in pairs(NFS.getDirectoryItems(SMODS.current_mod.path .. editions_dir)) do
--  local file, exception = SMODS.load_file(editions_dir .. "/" .. filename)
--  if exception then
--    error(exception)
--  end
--  file()
--end

for _, filename in pairs(NFS.getDirectoryItems(SMODS.current_mod.path .. consumables_dir)) do
  local file, exception = SMODS.load_file(consumables_dir .. "/" .. filename)
  if exception then
    error(exception)
  end
  file()
end

SMODS.current_mod.extra_tabs = function()
  local c_vanilla = HEX('ECE8DD')
  return {
    label = 'Credits',
    tab_definition_function = function()
    return {
      n = G.UIT.ROOT,
      config = {
        r = 0.1, 
        minw = 8, 
        minh = 6, 
        align = 'tl', 
        padding = 0.2,
        emboss = 0.05,
        colour = G.C.BLACK
      },
      nodes = {{
        n = G.UIT.R,
        config = {
          padding = 0.15,
          align = 'cl'
        },
        nodes = {{
          n = G.UIT.T,
          config = {
            text = 'Programming:',
            scale = 0.65,
            colour = G.C.BLUE
          }
        }}
      },{
        n = G.UIT.R,
        config = {
          align = 'cl'
        },
        nodes = {{
          n = G.UIT.T,
          config = {
            text = '- Seth Fusion',
            scale = 0.5,
            colour = c_vanilla
          }
        }}
      },{
        n = G.UIT.R,
          config = {
          padding = 0.15,
          align = 'cl'
        },
        nodes = {{
          n = G.UIT.T,
          config = {
            text = 'Art:',
            scale = 0.65,
            colour = G.C.RED
          }
        }}
      },{
        n = G.UIT.R,
          config = {
          align = 'cl'
        },
        nodes = {{
          n = G.UIT.T,
          config = {
            text = '- Seth Fusion: Minefield\n' .. 
              '- gsfg: Multiverse, Kepler, Mischief',
            scale = 0.5,
            colour = c_vanilla
          }
        }}
      }}
    }
    end
  }
end