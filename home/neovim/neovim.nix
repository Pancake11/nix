{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [{
      plugin = conform-nvim;
      type = "lua";
      config = ''
        require("conform").setup({
          formatters_by_ft = {
            cpp = { "clang_format" },
            nix = { "nixpkgs_fmt" },
            rust = { "rustfmt" },
            python = { "black" }
          },
        })

        require("conform").setup({
          format_on_save = {
            -- These options will be passed to conform.format()
            timeout_ms = 500,
            lsp_fallback = true,
          },
        })
      '';
    }
      cmp-nvim-lsp
      coc-eslint
      fzf-vim
      luasnip
      gruvbox
      {
        plugin = lsp-zero-nvim;
        type = "lua";
        config = builtins.readFile (./lsp-zero.lua);
      }
      nvim-cmp
      nvim-lspconfig
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = builtins.readFile (./tree-sitter.lua);
      }
      vim-airline
      vim-polyglot];
    withNodeJs = true;
    coc = {
      enable = true;
      settings = {
        languageserver = {
          nix = {
            command = "rnix-lsp";
            filetypes = [ "nix" ];
          };
        };
      };
    };
    extraConfig = ''
      colorscheme gruvbox

      set cc=120
      set scrolloff=5

      set mouse-=a
      set number relativenumber
      set list listchars=tab:.\ ,trail:.,extends:>,precedes:<,nbsp:_
      set autoindent expandtab tabstop=4 softtabstop=4 shiftwidth=4
      set backspace=start,eol,indent
      set hlsearch incsearch

      filetype plugin indent on
    '';
    extraPackages = with pkgs; [
      arduino-language-server
      cmake-language-server
      libcxx
      vhdl-ls
      terraform-ls
      nixfmt
      rnix-lsp
      rust-analyzer
      nodePackages.typescript-language-server
      pyright
      (python3.withPackages (ps: with ps; [
        black
        flake8
      ]))
    ];
    extraPython3Packages = (ps: with ps; [
      ps.jedi
    ]);
  };
}
