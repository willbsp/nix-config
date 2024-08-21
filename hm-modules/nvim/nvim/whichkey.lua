-- [[ Which-Key ]] --


--require('which-key').setup{
--  icons = {
--    mappings = false
--  }
--}

-- Document existing key chains
--require('which-key').add {
--  { '<leader>c', group = '[C]ode' },
--  { '<leader>d', group = '[D]ocument' },
--  { '<leader>r', group = '[R]ename' },
--  { '<leader>s', group = '[S]earch' },
--  { '<leader>w', group = '[W]orkspace' },
--  { '<leader>t', group = '[T]oggle' },
--  { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
--}

require('which-key').setup()

-- Document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
}
-- visual mode
require('which-key').register({
  ['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })
