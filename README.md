# Codcut VIM plugin

## Installation

This plugin works with both VIM and NeoVIM, and it requires either curl or wget in the PATH.

You can install it via [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'codcut/codcut-vim-plugin.git'
```

## Usage

Set your codcut token in the vim config (`~/.vimrc` or `~/.config/nvim/init.vim`):

```vim
let g:codcut_token = "<token>"
```

Then enter visual mode, highlight some code and run `:VisualPostToCodcut`

You might also want to setup a map:

```vim
vnoremap <leader>cc :<c-u>VisualPostToCodcut<cr>
```

## Credits

Big thanks to [mattn](https://github.com/mattn) and its [webapi-vim](https://github.com/mattn/webapi-vim)
