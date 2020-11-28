{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dincio";
  home.homeDirectory = "/home/dincio";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";

  # Packages
  home.packages = with pkgs; [
    # Basic terminal utils
    wget
    git

    # Basic graphical utils
    alacritty
    dmenu

    # Browsers
    firefox
    qutebrowser

    # Xorg configuration
    xorg.xmodmap

    # Programming
    nodejs # mainly for coc vim plugin

    # Poli
    alloy5
  ];

  # Git
  programs.git = {
    enable = true;

    userEmail = "dincio.montesi@gmail.com";
    userName = "Bietola";
    
    aliases = {
      co = "checkout";
      s = "status";
      A = "add -A";
      c = "commit";
      cano = "commit --amend --no-edit";
      adog = "log --all --decorate --oneline --graph";
      b = "branch";
      sc = "stash clear";
      su = "stash --include-untracked";
      p = "push";
    };
  };

  # Vim
  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      # Basic
      vimwiki
      vim-vsnip
      # TODO: Make Custom: dsf-vim
      vim-exchange
      vim-tabpagecd
      delimitMate
      vim-surround
      vim-dispatch
      vim-commentary
      vim-fugitive
      vim-vinegar
      vim-unimpaired
      vim-repeat
      sideways-vim
      ctrlp-vim

      # Cosmetic.
      # TODO: Fix characters: vim-airline
      # vim-airline-themes

      # Programming.
      vim-slime
      coc-nvim
      # Nix.
      vim-nix
      # Rust.
      # TODO: Make Custom: ron-vim
      # Haskell.
      vim-hindent
      # Lisp dialects.
      vim-sexp
      vim-sexp-mappings-for-regular-people

      # Colorschemes.
      # sacredforest-vim
      iceberg-vim

      # Poli.
      # TODO: Make custom: vim-alloy
    ];
    extraConfig = builtins.readFile ./nvim/init.vim;
  };
}
