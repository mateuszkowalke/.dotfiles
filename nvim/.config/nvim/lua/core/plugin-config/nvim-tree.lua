vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
    actions = {
        open_file = {
            quit_on_open = true
        }
    },
    git = {
        ignore = false
    }
})

vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')

-- always open nvim_tree on startup using autocmd
local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
