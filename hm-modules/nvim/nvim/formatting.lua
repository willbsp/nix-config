-- [[ Formatting ]] --

require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
  },
}

-- <leader>f to format
vim.keymap.set('n', '<leader>f', function()
  require('conform').format {
    async = true,
    lsp_fallback = true,
  }
end, { desc = '[F]ormat buffer' })
