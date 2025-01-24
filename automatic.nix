{ pkgs, lib, ... }:

{
    # Automatic updating
    system.autoUpgrade.enable = true;
    system.autoUpgrade.dates = "monthly";

    # Automatic cleanup
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
    };
}