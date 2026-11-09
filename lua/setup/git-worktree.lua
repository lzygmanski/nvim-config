return {
  'ThePrimeagen/git-worktree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  keys = {
    {
      '<leader>gw',
      function()
        require('telescope').extensions.git_worktree.git_worktrees()
      end,
      desc = 'Switch [G]it [W]orktree',
    },
    {
      '<leader>gW',
      function()
        require('telescope').extensions.git_worktree.create_git_worktree()
      end,
      desc = 'Create [G]it [W]orktree',
    },
  },
  config = function()
    local worktree = require 'git-worktree'

    worktree.setup {
      -- Ask before deleting a worktree from the Telescope picker (<C-d>)
      confirm_telescope_deletions = true,
      -- When the current file doesn't exist in the target worktree, open the
      -- tree at the new root instead of netrw (which is disabled by nvim-tree).
      update_on_change_command = 'NvimTreeOpen',
    }

    -- Keep nvim-tree rooted at the active worktree after switching/creating.
    worktree.on_tree_change(function(op, metadata)
      if op ~= worktree.Operations.Switch then
        return
      end
      local ok, api = pcall(require, 'nvim-tree.api')
      if ok then
        api.tree.change_root(metadata.path)
      end
    end)

    require('telescope').load_extension 'git_worktree'
  end,
}
