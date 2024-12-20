{ config, pkgs, ... }: {
  programs.neovim = {
    enable = true;
    catppuccin.enable = true;
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
      vim-markdown
      cmp-nvim-lsp
      vim-ccls
      vim-ocaml
      coc-eslint
      fzf-vim
      luasnip
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
    };
    extraConfig = ''
      set cc=120
      set scrolloff=5

      set mouse-=a
      set number relativenumber
      set list listchars=tab:.\ ,trail:.,extends:>,precedes:<,nbsp:_
      set autoindent expandtab tabstop=4 softtabstop=4 shiftwidth=4
      set backspace=start,eol,indent
      set hlsearch incsearch

      noremap <silent> <Space><Space> :Files<CR>

      filetype plugin indent on
    '';
    extraPackages = with pkgs; [
      ccls
      cmake-language-server
      libcxx
      nixfmt-rfc-style
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
