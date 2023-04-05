vim.opt.nu = true
vim.opt.rnu = true

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 3
vim.opt.autoread = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.swapfile = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.updatetime = 50

vim.opt.colorcolumn = '80'

vim.opt.exrc = true
vim.opt.secure = true

vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case --hidden'
vim.opt.grepformat = '%f:%l:%c:%m'
