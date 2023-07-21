require 'nvim-treesitter.configs'.setup {
    -- markdown and markdown_inline are required by lsp-saga
    ensure_installed = { 'javascript', 'typescript', 'json', 'css', 'html', 'go', 'sql', 'python', 'rust', 'c', 'markdown', 'markdown_inline' },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    ident = { enable = true },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
}
