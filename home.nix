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
      kitty
      kitty-themes
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

      settings = {
        display = {
          separator = " ➜ ";
        };

        logo = {
          padding = {
            top = 2;
          };
        };

        modules = [
          "break"
          {
            type = "os";
            key = "OS";
            keyColor = "31";
          }
          {
            type = "kernel";
            key = " ├  ";
            keyColor = "31";
          }
          {
            type = "packages";
            key = " ├ 󰏖 ";
            keyColor = "31";
          }
          {
            type = "shell";
            key = " └  ";
            keyColor = "31";
          }
          "break"
          {
            type = "wm";
            key = "WM   ";
            keyColor = "32";
          }
          {
            type = "wmtheme";
            key = " ├ 󰉼 ";
            keyColor = "32";
          }
          {
            type = "icons";
            key = " ├ 󰀻 ";
            keyColor = "32";
          }
          {
            type = "cursor";
            key = " ├  ";
            keyColor = "32";
          }
          {
            type = "terminal";
            key = " ├  ";
            keyColor = "32";
          }
          {
            type = "terminalfont";
            key = " └  ";
            keyColor = "32";
          }
          "break"
          {
            type = "host";
            format = "{5} {1} Type {2}";
            key = "PC   ";
            keyColor = "33";
          }
          {
            type = "cpu";
            format = "{1} ({3}) @ {7} GHz";
            key = " ├  ";
            keyColor = "33";
          }
          {
            type = "gpu";
            format = "{1} {2} @ {12} GHz";
            key = " ├ 󰢮 ";
            keyColor = "33";
          }
          {
            type = "memory";
            key = " ├  ";
            keyColor = "33";
          }
          {
            type = "disk";
            key = " ├ 󰋊 ";
            keyColor = "33";
          }
          {
            type = "swap";
            key = " ├ 󰋊 ";
            keyColor = "33";}
          }
          {
            type = "monitor";
            key = " ├  ";
            keyColor = "33";
          }
          {
            type = "player";
            key = " ├ 󰥠 ";
            keyColor = "33";
          }
          {
            type = "media";
            key = " └ 󰝚 ";
            keyColor = "33";
          }
          "break"
          {
            type = "uptime";
            key = "   Uptime   ";
          }
        ];
      };
    };
  };

  {
    programs.kitty = {
      enable = true;

      settings = {
        # Configuration de la police
        font = {
          family = "Fira Code";
          size = 12.0;
        };

        # Configuration des couleurs
        colors = {
          background = "#222222";
          foreground = "#F9F9F9";
        };

        # Historique du défilement
        scrolling = {
          history = 50000;
        };

        # Opacité de la fenêtre
        background_opacity = 0.8;

        # Thème de couleurs
        theme = "Gruvbox Dark";

        };
      };
    };



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
