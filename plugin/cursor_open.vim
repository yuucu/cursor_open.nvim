" Title:        cursor_open.nvim
" Description:  A plugin to open files in Cursor directly from Neovim
" Last Change:  2023
" Maintainer:   yuucu

" Prevents the plugin from being loaded multiple times
if exists('g:loaded_cursor_open')
    finish
endif
let g:loaded_cursor_open = 1

" Plugin setup should be done in lua
lua << EOF
if not vim.g.cursor_open_plugin_disabled then
  -- Setup will be called in user's config
  -- Automatically load plugin if the user hasn't set up manually
  if not package.loaded['cursor_open'] then
    require('cursor_open').setup()
  end
end
EOF
