--[[
  image.nvim — renders real images (not ASCII art) inside Neovim using
  the terminal's graphics protocol.
  https://github.com/3rd/image.nvim
  Docs: `:h image.nvim`

  Backend: "kitty" graphics protocol. iTerm2 >= 3.5.6 understands it
  (confirmed: this machine runs iTerm 3.6.5), so this works without
  Kitty/WezTerm. Processor: "magick_cli" — shells out to the `magick`
  CLI (`brew install imagemagick`) instead of needing a compiled
  LuaRocks binding, one less moving part.

  image.nvim ships no Telescope integration itself, so this file also
  wires a custom previewer: image files render inline in the preview
  pane instead of Telescope's default previewer garbling them as text.
  Overrides `require('telescope.config').values.buffer_previewer_maker`
  directly — must load after lua/plugins/telescope.lua.
--]]
vim.pack.add({
  { src = "https://github.com/3rd/image.nvim" },
}, { confirm = false })

require("image").setup({
  backend = "kitty",
  processor = "magick_cli",
  max_height_window_percentage = 50,
})

local image_api = require("image")
local previewers = require("telescope.previewers")

local supported_images = { "png", "jpg", "jpeg", "heic", "avif", "gif", "webp", "bmp" }
local current_image = nil
local current_path = nil

local function get_extension(filepath)
  return filepath:lower():match("%.([^.]+)$")
end

local function clear_current_image()
  if current_image then
    current_image:clear()
    current_image = nil
  end
end

local function image_previewer_maker(filepath, bufnr, opts)
  if current_path ~= filepath then
    clear_current_image()
  end
  current_path = filepath

  if vim.tbl_contains(supported_images, get_extension(filepath) or "") then
    -- Deferred: the preview window isn't sized yet on the first call in
    -- the same tick, which otherwise renders the image at the wrong size.
    vim.schedule(function()
      current_image = image_api.from_file(filepath, { window = opts.winid, buffer = bufnr })
      if current_image then
        current_image:render()
      end
    end)
  else
    previewers.buffer_previewer_maker(filepath, bufnr, opts)
  end
end

require("telescope.config").values.buffer_previewer_maker = image_previewer_maker
