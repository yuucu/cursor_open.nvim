# cursor_open.nvim

A Neovim plugin that allows you to open files in [Cursor](https://cursor.sh/) directly from Neovim.

## Features

- Open the current file in Cursor at the exact cursor position
- Smart workspace detection for Git repositories
- Option to open in a new Cursor window or reuse existing ones

## Installation

### Using [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use 'yuucu/cursor_open.nvim'
```

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  'yuucu/cursor_open.nvim',
  cmd = { 'CursorOpen' },
  keys = {
    { '<leader>oc', ':CursorOpen<CR>', desc = '[O]pen in [C]ursor' },
    { '<leader>oC', ':CursorOpen!<CR>', desc = '[O]pen in new [C]ursor window' },
  },
  config = function()
    require('cursor_open').setup()
  end
}
```

## Setup and Configuration

```lua
require('cursor_open').setup({
  -- Default options (these are the defaults)
  keymaps = {
    open = '<leader>oc',           -- Open in Cursor
    open_new = '<leader>oC',       -- Open in new Cursor window
  },
})
```

## Usage

- `:CursorOpen` - Open the current file in Cursor
- `:CursorOpen!` - Open the current file in a new Cursor window
- Or use the configured keymaps

## Requirements

- Neovim 0.5.0+
- Cursor installed and in your PATH

## License

MIT
