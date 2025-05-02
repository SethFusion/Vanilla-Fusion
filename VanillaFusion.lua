SMODS.Atlas {
  key = "VFAtlas",
  path = "VFJokers.png",
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