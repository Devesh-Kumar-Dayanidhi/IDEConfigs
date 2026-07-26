call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-autopairs'

call plug#end()

set termguicolors

set number
set norelativenumber

set autoindent
set smartindent
set cindent

set shiftwidth=4
set tabstop=4
set expandtab

set mouse=a

syntax enable
filetype plugin indent on

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'
let g:gruvbox_italic = 0
let g:gruvbox_bold = 1

let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_foreground = 'original'
let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_enable_bold = 1

set background=dark
colorscheme gruvbox
" Uncomment to use gruvbox-material instead of gruvbox:
"colorscheme gruvbox-material

lua << EOF

vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "c",
        "cpp",
        "asm",
        "lua",
        "bash",
        "json",
        "yaml",
        "cmake",
        "make",
    },

    callback = function()
        vim.treesitter.start()
    end,
})

local ok_pairs, npairs = pcall(require, "nvim-autopairs")

if ok_pairs then
    npairs.setup({
        check_ts = true,
    })
end

EOF

augroup asm_no_treesitter
    autocmd!
    autocmd FileType asm,gas,masm lua vim.treesitter.stop()
augroup END

" =========================
" Custom C/C++ Gruvbox
" =========================

" Variables
hi! link @variable GruvboxBlue
hi! link @variable.parameter GruvboxBlue
hi! link @field GruvboxBlue

" Preprocessor / macros
hi! link @keyword.directive GruvboxBlue
hi! link @constant.macro GruvboxBlue
hi! link @function.macro GruvboxBlue
hi! link @keyword.import GruvboxBlue

" Functions
hi! link @function GruvboxGreen
hi! link @function.call GruvboxGreen
hi! link @method GruvboxGreen

" Types
hi! link @type GruvboxYellow
hi! link @type.builtin GruvboxYellow
hi! link @constructor GruvboxYellow

" Keywords
hi! link @keyword GruvboxRed
hi! link @keyword.type GruvboxRed

" Storage modifiers
hi! link @keyword.modifier GruvboxOrange

" Punctuation
hi! link @punctuation.bracket GruvboxOrange
hi! link @punctuation.delimiter GruvboxOrange

if g:colors_name ==# 'gruvbox-material'
  " Variables
  hi! link @variable BlueBold
  hi! link @variable.parameter BlueBold
  hi! link @field BlueBold

  " Preprocessor / macros
  hi! link @keyword.directive BlueBold
  hi! link @constant.macro BlueBold
  hi! link @function.macro BlueBold
  hi! link @keyword.import BlueBold

  " Functions
  hi! link @function GreenBold
  hi! link @function.call GreenBold
  hi! link @method GreenBold

  " Types
  hi! link @type YellowBold
  hi! link @type.builtin YellowBold
  hi! link @constructor YellowBold

  " Keywords
   hi! link @keyword RedBold
   hi! link @keyword.type RedBold

  " Storage modifiers
  hi! link @keyword.modifier OrangeBold

  " Punctuation
  hi! link @punctuation.bracket OrangeBold
  hi! link @punctuation.delimiter OrangeBold
endif
