{ config, pkgs, ... }:

{
    hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      vpl-gpu-rt
      mesa
      vulkan-loader
      libva
    ];
  };
}