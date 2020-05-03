{ pkgs, lib, ... }:

let
  z = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/rupa/z/master/z.sh";
    sha256 = "0by1377wsvm75z97x7d2sfinsd1gqdgvmlci7c8d4xyrwg8hhvj8";
  };
in {
  home.packages = with pkgs; [
    zsh
  ];

  programs.zsh = lib.mkMerge [{
    enable = true;

    localVariables = {
      GPG_TTY = "$(tty)";
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.6.3";
          sha256 = "1h8h2mz9wpjpymgl2p7pc146c1jgb3dggpvzwm9ln3in336wl95c";
        };
      }
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "0.30.0";
          sha256 = "1yf4rz99acdsiy0y1v3bm65xvs2m0sl92ysz0rnnrlbd5amn283l";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.6.0";
          sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
        };
      }
      {
        name = "pure";
        src = pkgs.fetchFromGitHub {
          owner = "sindresorhus";
          repo = "pure";
          rev = "v1.12.0";
          sha256 = "1h04z7rxmca75sxdfjgmiyf1b5z2byfn6k4srls211l0wnva2r5y";
        };
      }
    ];

    initExtra = ''
      autoload -U promptinit; promptinit
      prompt pure
      source ${z}
    '';
  }

  (lib.mkIf pkgs.stdenv.isDarwin {
    localVariables = {
      NIX_PATH = "$HOME/.nix-defexpr/channels\${NIX_PATH:+:}$NIX_PATH";
    };

    initExtra = ''
      . $HOME/.nix-profile/etc/profile.d/nix.sh
      . $HOME/abacus/secrets/dev.env
    '';
  })];
}