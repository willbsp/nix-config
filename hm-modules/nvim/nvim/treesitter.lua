-- [[ Treesitter ]] --
require('nvim-treesitter.configs').setup {
  ensure_installed = {},
  auto_install = false,
  highlight = {
    enable = true,
    disable = { 'latex' },
  },
  indent = { enable = true },
}
