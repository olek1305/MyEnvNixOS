{ config, pkgs, ... }:

{
    # List packages installed in system profile. To search, run:
    # $ nix search wget
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
        intel-gpu-tools
        jetbrains-toolbox
        laravel
        libva
        linux-firmware
        lm_sensors
        nodejs_23
        ncurses
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
}

# command to install packages
# nix-shell -p neovim