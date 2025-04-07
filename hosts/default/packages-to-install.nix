{ config, pkgs, ... }:

let
  customNvtop = pkgs.nvtopPackages.full.overrideAttrs (oldAttrs: {
    version = "3.1.0+2025-03-22-git";
    src = pkgs.fetchFromGitHub {
      owner = "Syllo";
      repo = "nvtop";
      rev = "ca52d04f2e69ea945f67b93741a8530e502021b3";
      hash = "sha256-MQJDs5fee8uRqgaIF1lFcph+vNECyY4MBcK618zaisg=";
    };
    
    # Add libdrm to buildInputs
    buildInputs = oldAttrs.buildInputs ++ [pkgs.libdrm];
    
    # Make sure env.NIX_CFLAGS_COMPILE includes libdrm headers
    env = (oldAttrs.env or {}) // {
      NIX_CFLAGS_COMPILE = (oldAttrs.env.NIX_CFLAGS_COMPILE or "") + 
      " -isystem ${pkgs.lib.getDev pkgs.libdrm}/include/libdrm";
    };
    
    postFixup = ''
      ${oldAttrs.postFixup or ""}
      patchelf \
        --set-rpath "$(patchelf --print-rpath $out/bin/nvtop):${pkgs.lib.makeLibraryPath [pkgs.libdrm]}" \
        $out/bin/nvtop
    '';
  });
in
{
    environment.systemPackages = with pkgs; [
        act
        alacritty
        btop
        clinfo
        curl
        cmake
        dconf
        discord
        docker
        docker-compose
        foliate
        geeqie
        gimp
        go
        google-chrome
        pciutils
        libva-utils
        jetbrains-toolbox
        kubectl
        kubernetes
        kubernetes-helm
        laravel
        libva
        linux-firmware
        lm_sensors
        udev
        mesa-demos
        nodejs_23
        ncurses
        customNvtop
        oh-my-zsh
        pciutils
        (php82.withExtensions (exts: with pkgs.phpExtensions; [ mongodb ]))
        php82
        pkg-config
        steam
        symfony-cli
        systemd
        thunderbird
        vlc
        vscode
        wget
        zed-editor
        zsh

        # for Theme GTK Gnome
        ibus
        layan-gtk-theme
    ];

    nixpkgs.config.allowUnfree = true;

    programs.firefox.enable = true;
    
    # Grant the necessary permissions or run nvtop as root.
    security.wrappers.nvtop = {
        owner = "root";
        group = "root";
        capabilities = "cap_perfmon+ep";
        source = "${customNvtop}/bin/nvtop";
    };
}