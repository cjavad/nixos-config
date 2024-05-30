{ inputs, config, pkgs, lib, ... }: 

{
  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    gnupg
    alacritty
    python3
    git
    nil
    neofetch
    discord
    slack
    firefox
    curl
    htop
    killall
    fd
    catppuccin-papirus-folders
    waybar
    cliphist
    wofi
    wl-clipboard
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.phpstorm ["github-copilot"])
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.pycharm-professional ["github-copilot"]) 
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.clion ["github-copilot"])
  ];


  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
    Host github.com
      PreferredAuthentications publickey
      IdentityFile ${config.home.homeDirectory}/.ssh/id_rsa
    '';
  };

  programs.git = {
      enable = true;
      userName = "Javad Asgari Shafique";
      userEmail = "me@javad.sh";
      # signing.key = "CED5DD2923023B37!";
      # signing.signByDefault = true;
      extraConfig.github.user = "cjavad";
      extraConfig.core = {
        pull.rebase = true;
        autocrlf = "input";
      };
  };

  programs.gpg = {
    enable = true;
    mutableKeys = false;
    mutableTrust = false;
    publicKeys = [{
      trust = 5;
      source = builtins.fetchurl {
        url = "https://github.com/cjavad.gpg";
        sha256 = "9a3dfbc34d71aeaf79bbb078365eda6007ea62d446d34428d510b2fd11605dcb";
      };
    }];
    settings = {
      personal-cipher-preferences = "AES256 AES192 AES";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
      cert-digest-algo = "SHA512";
      s2k-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";
      charset = "utf-8";
      fixed-list-mode = "";
      no-comments = "";
      no-emit-version = "";
      no-greeting = "";
      keyid-format = "0xlong";
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      with-fingerprint = "";
      require-cross-certification = "";
      no-symkey-cache = "";
      use-agent = "";
      throw-keyids = "";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.firefox.enable = true;

#  programs.gpg-agent = {
#    enable = true;
#    enableZshIntegration = true;
#    enableSshSupport = true;
#  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf.enable = true;
  programs.fzf.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
    };
    autocd = true;
    enableCompletion = true;
    sessionVariables = {
      DIRENV_LOG_FORMAT = null;
    };

    oh-my-zsh.enable = true;

    plugins = [
      {
        name = "autopair";
        file = "share/zsh/zsh-autopair/autopair.zsh";
        src = pkgs.zsh-autopair;
      }
      {
        name = "fast-syntax-highlighting";
        file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
        src = pkgs.zsh-fast-syntax-highlighting;
      }
      {
        name = "z";
        file = "share/zsh-z/zsh-z.plugin.zsh";
        src = pkgs.zsh-z;
      }
    ];
  };

  # run the following command
  systemd.user.services.wl-paste-cliphist-watch = {
    serviceConfig.Type = "oneshot";
    serviceConfig.PassEnvironment = "DISPLAY";
    serviceConfig.ExecStart = 
      let script = pkgs.writeScript "wl-paste-cliphist-watch" ''
        #!${pkgs.stdenv.shell}
        wl-paste --watch cliphist store
      '';
    in script;
  };

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}; [
      vscode-marketplace.jnoortheen.nix-ide
      vscode-marketplace.github.copilot
    ];
  };

  programs.tmux = {
      enable = true;
      shortcut = "q";
      keyMode = "vi";
      clock24 = true;
      terminal = "screen-256color";
      customPaneNavigationAndResize = true;
      secureSocket = false;
  };
}
