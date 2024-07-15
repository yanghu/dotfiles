-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.loader.enable()

require("config.options")
require("config.lazy")
require("config.autocmds")
require("config.keymaps")

-- vim.cmd.colorscheme("catppuccin")
vim.cmd.colorscheme("gruvbox-material")
-- TODO: setup telescope grep keymappings for:
--   * grep test current project
--   * grep current buffer's dir
--   * glob grep?
--   * grep current buffer lines
--   * grep Git commits/bcommits,etc.
--   * Find file in git project
--
--   Grapple/Harpoon?
--
--   nvim outline
--
-- -- For profiling
-- --
-- local should_profile = os.getenv("NVIM_PROFILE")
-- if should_profile then
--   require("profile").instrument_autocmds()
--   if should_profile:lower():match("^start") then
--     require("profile").start("*")
--   else
--     require("profile").instrument("*")
--   end
-- end
--
-- local function toggle_profile()
--   local prof = require("profile")
--   if prof.is_recording() then
--     prof.stop()
--     vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.json" }, function(filename)
--       if filename then
--         prof.export(filename)
--         vim.notify(string.format("Wrote %s", filename))
--       end
--     end)
--   else
--     prof.start("*")
--   end
-- end
-- vim.keymap.set("", "<f1>", toggle_profile)
