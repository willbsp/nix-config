{ config, pkgs, lib, ... }: {
  home.username = "will";
  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    btop
    neofetch
  ];
  home.file.".ideavimrc".source = ./ideavim/.ideavimrc;
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
      remember_window_size = true;
      tab_bar_style = "fade";
      tab_bar_align = "left";
      tab_bar_min_tabs = 1;
      wayland_titlebar_color = "background";
      macos_titlebar_color = "background";
    };
  };
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

      # nix language server
      nil
      nixpkgs-fmt

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
}




