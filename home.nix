{ pkgs, nvim-pkg, ... }: {
  home.username = "will";
  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    btop
    fastfetch
    arduino-cli
  ];
  programs.git = {
    enable = true;
    userName = "willbsp";
    userEmail = "github-wills.12zz7@aleeas.com";
  };
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Frappe";
    settings = {
      cursor_shape = "beam";
      tab_bar_style = "fade";
      tab_bar_align = "left";
      tab_bar_min_tabs = 1;
      wayland_titlebar_color = "background";
      macos_titlebar_color = "background";
      remember_window_size = false;
      initial_window_width = "127c";
      initial_window_height = "50c";
      confirm_os_window_close = 0;
    };
  };
  programs.neovim = {
    enable = true;
    package = nvim-pkg.neovim-unwrapped;
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

      # docker compose language server
      docker-compose-language-service

      # vs code lang servers (for json)
      vscode-langservers-extracted

      # for clipboard integration
      xclip
      wl-clipboard

      # telescope dependency
      ripgrep

    ];
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


    ];
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
  programs.home-manager.enable = true;
}




