{ config, pkgs, ... }:

{
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        alacritty
        clinfo
        curl
        dconf
        discord
        docker
        docker-compose
        git
        go
        intel-media-sdk
        intel-vaapi-driver
        jetbrains.phpstorm
        kitty # for hyprland
        laravel
        libva
        linux-firmware
        mesa
        mesa-demos
        nodejs_23
        oh-my-zsh
        pciutils
        #php # 8.3.15
        #php83Packages.cyclonedx-php-composer
        (php82.withExtensions (exts: with pkgs.phpExtensions; [ mongodb ]))
        php82Packages.cyclonedx-php-composer
        symfony-cli
        thunderbird
        vscode
        vulkan-tools
        wget
        xdg-desktop-portal-hyprland
        xwayland
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