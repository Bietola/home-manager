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
    # Basic utils
    wget
    git
    dmenu
    xclip
    zip
    scrot
    xorg.xev
    acpi

    # Terminal
    alacritty

    # Browsers
    firefox
    qutebrowser
    transmission-gtk

    # Media
    mplayer
    ranger
    vlc

    # Looks
    redshift
    feh

    # System management
    # syncthing # TODO: Set this up properly...
    pass

    # Programming utils
    # neovim # TODO: Find out why this fails...
    # emacs # TODO: Setup doom emacs
    boxes
    haskellPackages.hindent
    haskellPackages.haskell-language-server

    # Programming
    stack
    nodejs # mainly for coc vim plugin

    # Xorg configuration
    xorg.xmodmap

    # Games
    minecraft-server
    logmein-hamachi

    # Poli
    alloy5
  ];

  ############
  # XSession #
  ############

  # Xsession/Xprofile
  xsession = {
    # TODO: Fix this overriding custom keyboard layout in nixos config
    enable = false;

    # Things that would go into ´~/.xprofile´
    initExtra = ''
      # Blue light is evil
      redshift -O 3000

      # Nature is relaxing
      feh --bg-scale ~/img/wp/forest.jpg
    '';
  };

  ############
  # Programs #
  ############

  # Bash
  programs.bash = {
    enable = true;

    shellAliases = {
      # Hacks
      sudo = "sudo ";

      # Better defaults
      ls = "ls --color=auto";
      xclip = "xclip -selection clipboard";

      # Utilities
      cpp = "rsync -ah --progress";
      cx = "chmod +x";
      power = "acpi";
      computer-info = "neofetch";
      show-ip4 = "wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1";

      # Quick access to files
      real="zathura ~/books/music/the-real-book.pdf";
    };

    bashrcExtra = ''
      # Environmental variables
      export EDITOR=nvim
      export TERMINAL=alacritty
      export BROWSER=qutebrowser
      export MYVIMRC=~/.config/nixpkgs/dotfiles/nvim/init.vim

      # Vim is the way
      set -o vi

      # Use <c-s> to go forward in reverse-i-search(es)
      stty -ixon
    '';
  };

  # Alacritty
  programs.alacritty = {
    enable = true;

    settings = {
      font.size = 11;
    };
  };

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

    extraConfig = {
      core.editor = "nvim";
      credential.helper = "store --file ~/.git-credentials";
      pull.rebase = "false";

      # Submodules
      diff.submodule = "log";
      status.submodulesummary = 1;
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

      # Cosmetic
      # TODO: Fix characters: vim-airline
      # vim-airline-themes

      # Snippets
      ultisnips

      # Programming
      vim-slime
      coc-nvim
      # Nix
      vim-nix
      # Rust
      # TODO: Make Custom: ron-vim
      # Lisp dialects.
      vim-sexp
      vim-sexp-mappings-for-regular-people

      # Colorschemes.
      # sacredforest-vim
      iceberg-vim

      # Poli.
      # TODO: Make custom: vim-alloy
    ];
    extraConfig = builtins.readFile ./dotfiles/nvim/init.vim;
  };

  # XMonad
  xsession.windowManager.xmonad = {
    enable = true;

    enableContribAndExtras = true;
    extraPackages = hpkgs: [
      hpkgs.xmonad
      hpkgs.xmonad-contrib
      hpkgs.xmonad-extras
    ];

    config = ./dotfiles/xmonad/xmonad.hs;
  };

  # Qutebrowser
  programs.qutebrowser = {
    enable = true;

    extraConfig = builtins.readFile ./dotfiles/qutebrowser/config.py;
  };
}
