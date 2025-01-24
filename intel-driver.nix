{ config, pkgs, ... }:

{
    hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
      libvdpau-va-gl
      intel-media-driver
      intel-compute-runtime

      # Optional
      #intel-vaapi-driver
      #mesa
      #vulkan-loader
      #libva
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ intel-vaapi-driver ];
  };
}

# lspci -k | grep -A 3 -i vga
# Check if Kernel modules has i915 then its ok.
