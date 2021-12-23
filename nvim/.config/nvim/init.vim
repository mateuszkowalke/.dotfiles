
"""""""""""""""""""""""""""""""""""""""""""
"""" Install plugins                   """"
"""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

" Stuff around lsp
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" Stuff around debugging
Plug 'puremourning/vimspector'

" Stuff around editing
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ray-x/lsp_signature.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'terrortylor/nvim-comment'
Plug 'phaazon/hop.nvim'
Plug 'SirVer/ultisnips'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

" Styling stuff
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bluz71/vim-moonfly-colors'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" Git stuff
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" File navigation stuff
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lua/popup.nvim' "telescope dependency
Plug 'nvim-lua/plenary.nvim' "telescope dependency
Plug 'nvim-telescope/telescope.nvim'

" Go specific stuff
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Prisma specific stuff - hopefully temporary until they fix prismals
Plug 'pantharshit00/vim-prisma'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""
"""" Basic config                      """"
"""""""""""""""""""""""""""""""""""""""""""

set number
set relativenumber
set exrc " enable local .nvimrc
set encoding=UTF-8
set mouse=a
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set smartindent
set autoindent
set copyindent      " copy indent from the previous line
set nohlsearch
set hidden
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set colorcolumn=100
set cot=menuone,noinsert,noselect shm+=c
let mapleader=" "
set ft=nasm " syntax highlighting for nasm assembly
set inccommand=nosplit                        " show substitutions incrementally
au! BufNewFile,BufRead *.svelte set ft=html " needed for svelte ls to work

nnoremap Y y$ " make capital Y behave like vim

"""""""""""""""""""""""""""""""""""""""""""
"""" Telescope config                  """"
"""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
lua << EOF
require('telescope').setup()
EOF

"""""""""""""""""""""""""""""""""""""""""""
"""" LSP Client config                 """"
"""""""""""""""""""""""""""""""""""""""""""

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'svelte', 'yamlls', 'pyright', 'prismals', 'bashls', 'gopls', 'rust_analyzer', 'tsserver', 'ccls', 'cssls', 'html', 'jsonls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

"""""""""""""""""""""""""""""""""""""""""""
"""" lsp_signature config              """"
"""""""""""""""""""""""""""""""""""""""""""

lua << EOF

require "lsp_signature".setup()

EOF

"""""""""""""""""""""""""""""""""""""""""""
"""" coq-nvim config                   """"
"""""""""""""""""""""""""""""""""""""""""""

" Autostart
" Keymap is set to work with autopairs
lua << EOF
vim.g.coq_settings = { ["auto_start"] = true, keymap = { recommended = false } }
EOF

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

"""""""""""""""""""""""""""""""""""""""""""
"""" TreeSitter config                 """"
"""""""""""""""""""""""""""""""""""""""""""

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF

"""""""""""""""""""""""""""""""""""""""""""
"""" UltiSnips config                 """"
"""""""""""""""""""""""""""""""""""""""""""

" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"""""""""""""""""""""""""""""""""""""""""""
"""" Colorscheme config                """"
"""""""""""""""""""""""""""""""""""""""""""

colorscheme moonfly

"""""""""""""""""""""""""""""""""""""""""""
"""" Gitsigns config                   """"
"""""""""""""""""""""""""""""""""""""""""""

lua << EOF
require('gitsigns').setup()
EOF

"""""""""""""""""""""""""""""""""""""""""""
"""" Autopairs config                  """"
"""""""""""""""""""""""""""""""""""""""""""

lua << EOF
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({ map_bs = false, map_cr = false })

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils= {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
EOF


"""""""""""""""""""""""""""""""""""""""""""
"""" VIM-GO config                     """"
"""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on

set autowrite


" Disable not needed things
let g:go_def_mapping_enabled = 0
let g:go_code_completion_enabled = 0

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1

" Camelcase struct tags
let g:go_addtags_transform = "camelcase"

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

" Map keys for most used commands.
" Ex: `\b` for building, `\r` for running and `\b` for running test.
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

"""""""""""""""""""""""""""""""""""""""""""
"""" nvim-comment config               """"
"""""""""""""""""""""""""""""""""""""""""""

lua << EOF
opts = {
  -- Linters prefer comment and line to have a space in between markers
  marker_padding = true,
  -- should comment out empty or whitespace only lines
  comment_empty = true,
  -- Should key mappings be created
  create_mappings = true,
  -- Normal mode mapping left hand side
  line_mapping = "<leader>cc",
  -- Visual/Operator mapping left hand side
  operator_mapping = "<leader>c",
  -- Hook function to call before commenting takes place
  hook = nil
}
require('nvim_comment').setup(opts)
EOF

"""""""""""""""""""""""""""""""""""""""""""
"""" Hop config                        """"
"""""""""""""""""""""""""""""""""""""""""""

nmap <leader>h :HopWord<CR>
lua << EOF
require'hop'.setup()
EOF

"""""""""""""""""""""""""""""""""""""""""""
"""" Vimspector config                 """"
"""""""""""""""""""""""""""""""""""""""""""

let g:vimspector_enable_mappings='HUMAN'
nmap <leader>vl :call vimspector#Launch()<CR>
nmap <leader>vr :VimspectorReset<CR>
nmap <leader>ve :VimspectorEval
nmap <leader>vw :VimspectorWatch
nmap <leader>vo :VimspectorShowOutput
nmap <leader>vi <Plug>VimspectorBalloonEval
xmap <leader>vi <Plug>VimspectorBalloonEval

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval

" custom mapping to go out of debugging mode
nmap <F2> :VimspectorReset<CR>

let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-go', 'CodeLLDB', 'vscode-node-debug2' ]

"""""""""""""""""""""""""""""""""""""""""""
"""" Devicons config                   """"
"""""""""""""""""""""""""""""""""""""""""""

lua << EOF
require("nvim-web-devicons").setup {
    override = {
      zsh = { icon = "", color = "#428850", name = "Zsh" },
      lua = { icon = "", color = "#4E99DF", name = "Lua" },
      Md = { icon = "", color = "#6BD02B", name = "Md" },
      md = { icon = "", color = "#6BD02B", name = "md" },
      MD = { icon = "", color = "#6BD02B", name = "MD" },
      [".gitignore"] = { icon = "", color = "#F14E32", name = "GitIgnore" },
    },
  }
  require'nvim-web-devicons'.get_icons()
EOF

"""""""""""""""""""""""""""""""""""""""""""
"""" NvimTree config                   """"
"""""""""""""""""""""""""""""""""""""""""""

let g:nvim_tree_width = 40 "30 by default, can be width_in_columns or 'width_in_percent%'
let g:nvim_tree_auto_ignore_ft = [ 'startify', 'dashboard' ] "empty by default, don't auto open tree on specific filetypes.
let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
let g:vim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_disable_window_picker = 0 "0 by default, will disable the window picker.
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 0,
    \ 'files': 1,
    \ 'folder_arrows': 0,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen and NvimTreeClose are also available if you need them

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue

lua << EOF
require'nvim-tree'.setup({
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    },
    number = false,
    relativenumber = false
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  }
})
EOF
