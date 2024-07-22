{ pkgs, lib, config, ... }: {
  options = {
    nvim.enable = lib.mkEnableOption "Enables neovim configuration";
    nvim.latexSupport = lib.mkEnableOption "Installs TexLive";
  };
  config = lib.mkIf config.nvim.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      defaultEditor = true;
      extraPackages = with pkgs; [

        # lua
        lua-language-server
        stylua

        # arduino
        # ensure: arduino-cli core install ......
        arduino-language-server
        arduino-cli
        clang-tools

        # nix language server
        nil
        nixpkgs-fmt

        # bash language server
        nodePackages.bash-language-server

        # docker compose language server
        docker-compose-language-service

        # vs code lang servers (for json)
        vscode-langservers-extracted

        # for clipboard integration
        xclip
        wl-clipboard

        # telescope dependency
        ripgrep

      ] ++ lib.optionals config.nvim.latexSupport [ pkgs.texliveFull pkgs.texlab ];
      plugins = with pkgs.vimPlugins; [

        # Theme
        {
          plugin = catppuccin-nvim;
          config = "colorscheme catppuccin-frappe";
        }

        # LSP
        nvim-lspconfig
        fidget-nvim # LSP status updates
        neodev-nvim # Configures Lua LSP for Neovim configuration

        # Formatting
        conform-nvim

        # Treesitter
        nvim-treesitter.withAllGrammars

        # Status line
        lualine-nvim

        # Which key
        which-key-nvim

        # Telescope
        telescope-nvim
        plenary-nvim # required dependency
        telescope-ui-select-nvim # optional

        # Completion
        nvim-cmp # completion engine (text input -> completions list)
        luasnip # snippet engine (snippet -> insert into file)
        cmp-path # completions from path
        cmp-nvim-lsp # completions from lsp

        # Git integration
        gitsigns-nvim
        vim-fugitive # git wrapper

        # Neoscroll
        neoscroll-nvim

        # Auto pairs
        nvim-autopairs

        # Neo-tree
        neo-tree-nvim
        nui-nvim # required dependency

        # Detect tabs vs spaces automatically
        vim-sleuth


      ] ++ lib.optionals config.nvim.latexSupport [ pkgs.vimPlugins.vimtex ];
      extraLuaConfig = ''
        ${builtins.readFile ./nvim/options.lua}
        ${builtins.readFile ./nvim/lsp.lua}
        ${builtins.readFile ./nvim/formatting.lua}
        ${builtins.readFile ./nvim/completion.lua}
        ${builtins.readFile ./nvim/treesitter.lua}
        ${builtins.readFile ./nvim/whichkey.lua}
        ${builtins.readFile ./nvim/lualine.lua}
        ${builtins.readFile ./nvim/telescope.lua}
        ${builtins.readFile ./nvim/git.lua}
        ${builtins.readFile ./nvim/keymaps.lua}
        ${builtins.readFile ./nvim/neoscroll.lua}
        ${builtins.readFile ./nvim/autopairs.lua}
        ${builtins.readFile ./nvim/neotree.lua}
      '';
    };

  };
}
