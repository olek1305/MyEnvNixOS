{ config, pkgs, ... }:

{
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        alacritty
        clinfo
        curl
        discord
        docker
        docker-compose
        geany
        git
        intel-media-sdk
        kitty
        libva
        linux-firmware
        mesa
        mesa-demos
        pciutils
        pkgs.jetbrains.phpstorm
        pkgs.vscode
        pkgs.vulkan-tools
        wget
    ];
}

# command to install packages
# nix-shell -p neovim