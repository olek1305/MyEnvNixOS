{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
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
        git
        gimp
        go
        pciutils
        libva-utils
        jetbrains-toolbox
        laravel
        libdrm
        libva
        linux-firmware
        lm_sensors
        udev
        mesa-demos
        nodejs_23
        ncurses
        nvtop
        oh-my-zsh
        pciutils
        #php # 8.3.15
        #php83Packages.cyclonedx-php-composer
        (php82.withExtensions (exts: with pkgs.phpExtensions; [ mongodb ]))
        php82
        pkg-config
        # php82Packages.cyclonedx-php-composer
        steam
        symfony-cli
        systemd
        thunderbird
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

    nixpkgs.overlays = [
        (final: prev: {
            nvtopPackages = 
            let 
                nvtopOverride = oldAttrs: oldAttrs // {
                    version = "3.1.0+2025-03-22-git";
                    src = prev.fetchFromGitHub {
                        owner = "Syllo";
                        repo = "nvtop";
                        rev = "ca52d04f2e69ea945f67b93741a8530e502021b3";
                        hash = "sha256-MQJDs5fee8uRqgaIF1lFcph+vNECyY4MBcK618zaisg=";
                    };
                    
                    # Add libdrm to buildInputs regardless of needDrm
                    buildInputs = oldAttrs.buildInputs ++ [prev.libdrm];
                    
                    # Make sure env.NIX_CFLAGS_COMPILE includes libdrm headers
                    env = (oldAttrs.env or {}) // {
                        NIX_CFLAGS_COMPILE = (oldAttrs.env.NIX_CFLAGS_COMPILE or "") + 
                        " -isystem ${prev.lib.getDev prev.libdrm}/include/libdrm";
                    };
                    
                    # Update postFixup to include libdrm in the rpath
                    # Using a simpler approach that doesn't rely on if condition
                    postFixup = ''
                        ${oldAttrs.postFixup or ""}
                        patchelf \
                            --set-rpath "$(patchelf --print-rpath $out/bin/nvtop):${prev.lib.makeLibraryPath [prev.libdrm]}" \
                            $out/bin/nvtop
                    '';
                };
            in 
            builtins.mapAttrs (name: pkg: 
                pkg.overrideAttrs nvtopOverride
            ) prev.nvtopPackages;
            
            # Also update the main nvtop package
            nvtop = final.nvtopPackages.full;
        })
    ];
}

# command to install packages
# nix-shell -p neovim