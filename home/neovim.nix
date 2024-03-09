{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      nerdtree
      coc-json
      coc-sh
      coc-docker
      coc-clangd
      coc-pyright
      coc-python
      coc-yaml
      fzf-vim
      gruvbox
      nvim-lspconfig
      vim-airline
      vim-polyglot
    ];
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

      function! CheckBackspace() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
      endfunction

      inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1):
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
      inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>" '';
    extraPackages = with pkgs; [
      nixfmt
      rnix-lsp
    ];
  };
}
