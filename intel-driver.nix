{ config, pkgs, ... }:

{
    hardware.graphics = {
    enable = true;
    enable32Bit = true; # For Steam
    extraPackages = with pkgs; [
      vpl-gpu-rt # For Video/Photos
      libvdpau-va-gl # VDPAU driver with VA-API/OpenGL backend.
      intel-media-driver # Newer driver graphics
      intel-compute-runtime # implementation for OpenCL.
      intel-vaapi-driver # for old graphics
      mesa # for OpenGL, Vulan and another API graphics
      vulkan-tools
      vulkan-loader
      libva
      libdrm 
      pciutils
      intel-gpu-tools
    ];

    extraPackages32 = with pkgs.pkgsi686Linux; [ 
        intel-vaapi-driver
        intel-media-driver
        mesa
      ];
  };

  # Force Intel-media-driver
  environment.sessionVariables = { 
    LIBVA_DRIVER_NAME = "iHD"; # Force use of intel-media-driver
    # Enable debugging for Intel GPU drivers
    INTEL_DEBUG = "perf";
    # Force intel compute runtime for OpenCL
    OCL_ICD_VENDORS = "intel";
  };
}

# Check what nixos is use kernel module and driver below command:
# lspci -k | grep -A 3 -i vga
