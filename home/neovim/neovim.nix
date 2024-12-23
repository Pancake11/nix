{ lib, pkgs, ... }:
let
  readLuaConfig = plugin:
    {
      inherit plugin;
      type = "lua";
      config = builtins.readFile ./plugins/${plugin.pname}.lua;
    };
in
{
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; map readLuaConfig [
      conform-nvim
      lualine-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-tree-lua
      nvim-treesitter.withAllGrammars
      telescope-nvim
    ] ++ [
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      nvim-web-devicons
    ];

    extraLuaConfig = lib.strings.concatLines ([
      "-- nvim-tree"
      "vim.g.loaded_netrw = 1"
      "vim.g.loaded_netrwPlugin = 1"
    ] ++ (map builtins.readFile [
      ./options.lua
      ./mappings.lua
    ]));

    extraPackages = with pkgs; [
      # LSP
      ccls
      rust-analyzer

      # Formatters
      black
      clang-tools
      nixpkgs-fmt
      rustfmt
      stylua

      # Utils
      ripgrep
      fd
    ];
  };
}

