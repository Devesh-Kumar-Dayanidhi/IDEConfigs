call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'windwp/nvim-autopairs'

call plug#end()

set background=dark
colorscheme gruvbox

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "asm" }, -- you can add more languages
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require("nvim-autopairs").setup({
  check_ts = true,  -- enable Tree-sitter integration
})
EOF

syntax enable
filetype plugin indent on

set number
set smartindent
set autoindent
set shiftwidth=4
set tabstop=4

" Define Gruvbox colors (from gruvbox palette)
" For full palette, see: https://github.com/morhetz/gruvbox/wiki/Palette

hi! link @keyword.import GruvboxBlue
hi! link @variable GruvboxBlue
hi! link @variable.builtin GruvboxBlue
hi! link @type GruvboxYellow
hi! link @type.builtin GruvboxYellow
hi! link @type.definition GruvboxYellow
hi! link @punctuation.bracket GruvboxOrange
hi! link @punctuation.delimiter GruvboxOrange
hi! link @function.macro GruvboxBlue
hi! link @keyword.directive GruvboxBlue
