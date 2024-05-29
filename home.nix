{ inputs, config, pkgs, lib, ... }: 

{
  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    gnupg
    python3
    git
    firefox
    htop
    killall
  ];

  programs.git = {
      enable = true;
      userName = "Javad Asgari Shafique";
      userEmail = "me@javad.sh";
      # signing.key = "CED5DD2923023B37!";
      # signing.signByDefault = true;
      extraConfig.github.user = "cjavad";
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

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
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
    autosuggestion.enable = true;
    enableCompletion = true;
    defaultKeymap = "vicmd";
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

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}; [
      vscode-marketplace.jnoortheen.nix-ide
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
