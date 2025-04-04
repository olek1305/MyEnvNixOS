{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./intel-driver.nix
      ./packages-to-install.nix
      ./automatic.nix
      ./environment.nix
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot = {
    # If no dual-boot remove all loader.{grub and efi} and remove # below systemd and efi.
    # loader.systemd-boot.enable = true;
    # loader.efi.canTouchEfiVariables = true;

    # Dual-boot
    loader = {
      grub = {
        enable = true;
        device = "nodev";  # Required for UEFI
        efiSupport = true;  # Enable EFI support
        useOSProber = true;  # Detect other operating systems (like Windows)
      };
      efi = {
        canTouchEfiVariables = true;  # Allow GRUB to write to EFI variables
        efiSysMountPoint = "/boot";  # Mount point for the EFI partition
      };
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "btrfs" "xe" "i915" ];
  };
 
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.xaxa = {
    isNormalUser = true;
    description = "xaxa";
    extraGroups = [ "networkmanager" "wheel" "docker" "git" ];
  };

  # Docker settings
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      "default-address-pools" = [
        { "base" = "172.27.0.0/16"; "size" = 24; }
      ];
    };
  };
  
  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "xaxa";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # allow users in "users" group to reboot and shutdown without auth prompt
  # allow users in "wheel" group unrestricted access to specific applications
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }

      if (
        subject.isInGroup("wheel") &&
          (
            action.id.startsWith("org.freedesktop.") ||
            action.id.startsWith("com.jetbrains.") ||
            action.id.startsWith("com.toolbox.") ||
            action.id.startsWith("com.visualstudio.code.")
          )
      ) {
        return polkit.Result.YES;
      }
    });
  '';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
