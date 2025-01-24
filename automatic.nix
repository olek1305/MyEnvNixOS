{ pkgs, lib, ... }:

{
    # Automatic updating
    system.autoUpgrade.enable = true;
    system.autoUpgrade.dates = "monthly"

    # Automatic cleanup
    nix.gc.automatic = true;
    nix.gc.dates = "weekly";
    nix.gc.options = "--delete-older-than 7d";
    nix.settings.auto-optimise-store = true;
}