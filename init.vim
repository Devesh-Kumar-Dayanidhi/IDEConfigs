" ============================================================
" Plugin Manager
" ============================================================

call plug#begin('~/.local/share/nvim/plugged')

" ------------------------------------------------------------
" Theme
" ------------------------------------------------------------

Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'

" ------------------------------------------------------------
" Syntax / Editing
" ------------------------------------------------------------

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'windwp/nvim-autopairs'

" ------------------------------------------------------------
" File Explorer
" ------------------------------------------------------------

Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

" ------------------------------------------------------------
" Fuzzy Finder
" ------------------------------------------------------------

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'

" ------------------------------------------------------------
" LSP
" ------------------------------------------------------------

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" ------------------------------------------------------------
" Autocomplete
" ------------------------------------------------------------

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

" ------------------------------------------------------------
" Git
" ------------------------------------------------------------

Plug 'lewis6991/gitsigns.nvim'

" ------------------------------------------------------------
" Terminal
" ------------------------------------------------------------

Plug 'akinsho/toggleterm.nvim'

call plug#end()

" ============================================================
" General Options
" ============================================================

set termguicolors

set number
set norelativenumber

set autoindent
set smartindent
set cindent

set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

set mouse=a

set clipboard=unnamedplus

set splitright
set splitbelow

set nocursorline
set signcolumn=no

set scrolloff=8

set ignorecase
set smartcase

set hidden

set undofile

set updatetime=250

syntax enable
filetype plugin indent on

" ============================================================
" Gruvbox
" ============================================================

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

" Uncomment this instead if you want gruvbox-material:
"
" colorscheme gruvbox-material


" ============================================================
" Leader Key
" ============================================================

let mapleader = " "

" ============================================================
" VS Code-like Keybindings
" ============================================================

" ------------------------------------------------------------
" File Explorer
" Ctrl+B
" ------------------------------------------------------------

nnoremap <C-b> :NvimTreeToggle<CR>

" ------------------------------------------------------------
" Save
" Ctrl+S
" ------------------------------------------------------------

nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>

" ------------------------------------------------------------
" Quit
" Ctrl+Q
" ------------------------------------------------------------

nnoremap <C-q> :q!<CR>

" ------------------------------------------------------------
" Telescope
" ------------------------------------------------------------

" Ctrl+P = Find files
nnoremap <C-p> <cmd>Telescope find_files<CR>

" Ctrl+Shift+F = Search project
nnoremap <C-S-f> <cmd>Telescope live_grep<CR>

" Ctrl+F = Search Current File
nnoremap <C-f> <cmd>Telescope current_buffer_fuzzy_find<CR>

" Ctrl+Shift+P = Command palette
nnoremap <C-S-p> <cmd>Telescope commands<CR>

" Leader + B = Open buffers
nnoremap <leader>b <cmd>Telescope buffers<CR>

" Leader + H = Help
nnoremap <leader>h <cmd>Telescope help_tags<CR>

" ============================================================
" Window Navigation
" ============================================================

" Ctrl + Arrow keys
nnoremap <C-Left>  <C-w>h
nnoremap <C-Right> <C-w>l
nnoremap <C-Up>    <C-w>k
nnoremap <C-Down>  <C-w>j

" ============================================================
" Terminal
" ============================================================

nnoremap <C-`> :ToggleTerm<CR>
tnoremap <C-`> <C-\><C-n>:ToggleTerm<CR>

" ============================================================
" Treesitter
" ============================================================

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
        pcall(vim.treesitter.start)
    end,
})

vim.diagnostic.config({
    underline = false,
})

EOF

" ============================================================
" Disable Treesitter for Assembly
" ============================================================

augroup asm_no_treesitter
    autocmd!
    autocmd FileType asm,gas,masm lua pcall(vim.treesitter.stop)
augroup END

" ============================================================
" Auto Pairs
" ============================================================

lua << EOF

local ok_pairs, npairs = pcall(require, "nvim-autopairs")

if ok_pairs then
    npairs.setup({
        check_ts = true,
    })
end

EOF

" ============================================================
" Nvim Tree
" ============================================================

lua << EOF

local ok, nvim_tree = pcall(require, "nvim-tree")

if ok then
    nvim_tree.setup({
        sort = {
            sorter = "case_sensitive",
        },

        view = {
            width = 30,
        },

        renderer = {
            group_empty = true,
        },

        filters = {
            dotfiles = false,
        },
    })
end

EOF

" ============================================================
" Telescope
" ============================================================

lua << EOF

local ok, telescope = pcall(require, "telescope")

if ok then
    telescope.setup({
        defaults = {
            layout_strategy = "horizontal",

            layout_config = {
                preview_width = 0.5,
            },

            sorting_strategy = "ascending",

            file_ignore_patterns = {
                ".git/",
                "node_modules/",
                "build/",
                "dist/",
            },
        },
    })
end

EOF

" ============================================================
" Mason
" ============================================================

lua << EOF

local ok, mason = pcall(require, "mason")

if ok then
    mason.setup()
end

EOF

" ============================================================
" LSP + Mason
" ============================================================

lua << EOF

local ok_mason, mason_lspconfig = pcall(require, "mason-lspconfig")

if ok_mason then
    mason_lspconfig.setup({
        ensure_installed = {
            "clangd",
            "lua_ls",
            "bashls",
            "jsonls",
            "yamlls",
            "cmake",
        },

        automatic_installation = true,
    })
end

EOF

" ============================================================
" Completion
" ============================================================

lua << EOF

local ok_cmp, cmp = pcall(require, "cmp")

if ok_cmp then

    cmp.setup({

        mapping = cmp.mapping.preset.insert({

            ["<C-Space>"] = cmp.mapping.complete(),

            ["<CR>"] = cmp.mapping.confirm({
                select = true,
            }),

            ["<Tab>"] = cmp.mapping.select_next_item(),

            ["<S-Tab>"] = cmp.mapping.select_prev_item(),

            ["<C-e>"] = cmp.mapping.abort(),

        }),

        sources = {
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
        },

    })

end

EOF

" ============================================================
" LSP Configuration
" ============================================================

lua << EOF

local capabilities = vim.lsp.protocol.make_client_capabilities()

local ok_cmp_lsp, cmp_nvim_lsp =
    pcall(require, "cmp_nvim_lsp")

if ok_cmp_lsp then
    capabilities =
        cmp_nvim_lsp.default_capabilities(capabilities)
end


local servers = {
    clangd = {},
    lua_ls = {},
    bashls = {},
    jsonls = {},
    yamlls = {},
    cmake = {},
}

for server, config in pairs(servers) do

    config.capabilities = capabilities

    vim.lsp.config(server, config)

    vim.lsp.enable(server)

end

EOF

" ============================================================
" LSP Keybindings
" ============================================================

lua << EOF

vim.api.nvim_create_autocmd("LspAttach", {

    callback = function(args)

        local opts = {
            buffer = args.buf,
        }

        -- Go to definition
        vim.keymap.set(
            "n",
            "gd",
            vim.lsp.buf.definition,
            opts
        )

        -- Find references
        vim.keymap.set(
            "n",
            "gr",
            vim.lsp.buf.references,
            opts
        )

        -- Hover documentation
        vim.keymap.set(
            "n",
            "K",
            vim.lsp.buf.hover,
            opts
        )

        -- Rename
        vim.keymap.set(
            "n",
            "<leader>rn",
            vim.lsp.buf.rename,
            opts
        )

        -- Code action
        vim.keymap.set(
            "n",
            "<leader>ca",
            vim.lsp.buf.code_action,
            opts
        )

        -- Format
        vim.keymap.set(
            "n",
            "<leader>f",
            function()
                vim.lsp.buf.format({
                    async = true,
                })
            end,
            opts
        )

    end,

})

EOF

" ============================================================
" Git Signs
" ============================================================

lua << EOF

local ok, gitsigns = pcall(require, "gitsigns")

if ok then
    gitsigns.setup()
end

EOF

" ============================================================
" Git Keybindings
" ============================================================

nnoremap <leader>gp :Gitsigns preview_hunk<CR>
nnoremap <leader>gr :Gitsigns reset_hunk<CR>
nnoremap <leader>gs :Gitsigns stage_hunk<CR>


" ============================================================
" ToggleTerm
" ============================================================

lua << EOF

local ok, toggleterm = pcall(require, "toggleterm")

if ok then

    toggleterm.setup({
        size = 20,

        open_mapping = [[<c-\>]],

        direction = "horizontal",

        shade_terminals = false,

        persist_size = true,

    })

end

EOF

" ============================================================
" Custom C/C++ Gruvbox
" ============================================================

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

" ============================================================
" Gruvbox Material Overrides
" ============================================================

if g:colors_name ==# 'gruvbox-material'

    hi! link @variable BlueBold
    hi! link @variable.parameter BlueBold
    hi! link @field BlueBold

    hi! link @keyword.directive BlueBold
    hi! link @constant.macro BlueBold
    hi! link @function.macro BlueBold
    hi! link @keyword.import BlueBold

    hi! link @function GreenBold
    hi! link @function.call GreenBold
    hi! link @method GreenBold

    hi! link @type YellowBold
    hi! link @type.builtin YellowBold
    hi! link @constructor YellowBold

    hi! link @keyword RedBold
    hi! link @keyword.type RedBold

    hi! link @keyword.modifier OrangeBold

    hi! link @punctuation.bracket OrangeBold
    hi! link @punctuation.delimiter OrangeBold

endif
