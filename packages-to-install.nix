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
        geany
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
        php # 8.3.15
        php83Packages.cyclonedx-php-composer
        symfony-cli
        vscode
        vulkan-tools
        xdg-desktop-portal-hyprland
        xwayland
        wget
        zsh
    ];

    nixpkgs.config.allowUnfree = true;

    programs.firefox.enable = true;
}

# command to install packages
# nix-shell -p neovim