{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gabriel";
  home.homeDirectory = "/home/gabriel";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
      alacritty
      fastfetch
  ];

  {
    programs.alacritty = {
      enable = true;

      # Configuration inline de Alacritty. Toutes ces options seront traduites en YAML
      # et placées dans le fichier de configuration d’Alacritty.
      settings = {
        # Configuration de la fenêtre
        window = {
          decorations = "full";  # ["full", "none", ou "transparent"]
          # Exemples pour le mode au démarrage : "Maximized", "Fullscreen", "Windowed"
          startup_mode = "Windowed";
        };

        # Configuration de la police
        font = {
          normal = {
            family = "Fira Code";
            style = "Regular";
          };
          size = 12.0;
        };

        # Configuration des couleurs
        colors = {
          primary = {
            background = "#222222";
            foreground = "#F9F9F9";
          };
          #cursor = {
           # text = "#1d1f21";
           # cursor = "#c5c8c6";
          };
        };

        # Historique du défilement
        scrolling = {
          history = 50000;
        };
      };
        # Dimension de la fenêtre
        window.dimensions = {
          columns = 120;
          lines = 30;

      # Opacité de la fenêtre
        window.opacity = {
        opacity = 0.8;

    };
  }

      {
     programs.fastfetch = {
        enable = true;
        # Création du fichier de configuration Fastfetch dans ~/.config/fastfetch/config.jsonc
          home.file.".config/fastfetch/config.jsonc" = {
            text = ''
              // Load with --load-config examples/7.jsonc
              // Note that you must replace the image path to an existing image to display it.

              {
                "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
                "logo": {
                  "padding": {
                    "top": 2
                  }
                },
                "display": {
                  "separator": " -> "
                },
                "modules": [
                  "title",
                  "separator",
                  {
                    "type": "os",
                    "key": " OS",
                    "keyColor": "yellow",
                    "format": "{2}"
                  },
                  {
                    "type": "os",
                    "key": "├{icon}",
                    "keyColor": "yellow"
                  },
                  {
                    "type": "kernel",
                    "key": "├",
                    "keyColor": "yellow"
                  },
                  {
                    "type": "packages",
                    "key": "├󰏖",
                    "keyColor": "yellow"
                  },
                  {
                    "type": "shell",
                    "key": "└",
                    "keyColor": "yellow"
                  },
                  "break",
                  {
                    "type": "wm",
                    "key": " DE/WM",
                    "keyColor": "blue"
                  },
                  {
                    "type": "lm",
                    "key": "├󰧨",
                    "keyColor": "blue"
                  },
                  {
                    "type": "wmtheme",
                    "key": "├󰉼",
                    "keyColor": "blue"
                  },
                  {
                    "type": "icons",
                    "key": "├󰀻",
                    "keyColor": "blue"
                  },
                  {
                    "type": "terminal",
                    "key": "├",
                    "keyColor": "blue"
                  },
                  {
                    "type": "wallpaper",
                    "key": "└󰸉",
                    "keyColor": "blue"
                  },
                  "break",
                  {
                    "type": "host",
                    "key": "󰌢 PC",
                    "keyColor": "green"
                  },
                  {
                    "type": "cpu",
                    "key": "├󰻠",
                    "keyColor": "green"
                  },
                  {
                    "type": "gpu",
                    "key": "├󰍛",
                    "keyColor": "green"
                  },
                  {
                    "type": "disk",
                    "key": "├",
                    "keyColor": "green"
                  },
                  {
                    "type": "memory",
                    "key": "├󰑭",
                    "keyColor": "green"
                  },
                  {
                    "type": "swap",
                    "key": "├󰓡",
                    "keyColor": "green"
                  },
                  {
                    "type": "display",
                    "key": "├󰍹",
                    "keyColor": "green"
                  },
                  {
                    "type": "uptime",
                    "key": "└󰅐",
                    "keyColor": "green"
                  },
                  "break",
                  {
                    "type": "sound",
                    "key": " SOUND",
                    "keyColor": "cyan"
                  },
                  {
                    "type": "player",
                    "key": "├󰥠",
                    "keyColor": "cyan"
                  },
                  {
                    "type": "media",
                    "key": "└󰝚",
                    "keyColor": "cyan"
                  },
                  "break",
                  "colors"
                ]
              }
            '';

     };
      }


  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gabriel/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
