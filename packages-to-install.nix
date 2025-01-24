{ config, pkgs, ... }:

{
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        pkgs.jetbrains.phpstorm
        pkgs.docker
        pkgs.docker-compose
        pkgs.discord
        pkgs.vscode
        pkgs.geany
        pkgs.intel-media-sdk
        pkgs.mesa
        pkgs.libva
        pkgs.vulkan-tools
        wget
        curl
        clinfo
        pciutils
        linux-firmware
        mesa-demos
        alacritty
        git
    ];
}

# command to install packages
# nix-shell -p neovim