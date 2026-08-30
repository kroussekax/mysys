{ config, ...}:
{
	services = {
		udev.extraRules = ''
			KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
			'';

		udev.packages = with pkgs; [
			platformio-core.udev
			iio-sensor-proxy
			yubikey-personalization
		];

		xserver.enable = true;

		desktopManager.gnome = {
			enable = true;
		};

		displayManager.sddm = {
			enable = true;
			theme = "pixie";
			wayland.enable = true;

			package = pkgs.kdePackages.sddm;

			extraPackages = [
				pkgs.kdePackages.qtsvg
				pkgs.kdePackages.qtdeclarative
				pkgs.kdePackages.qt5compat
			];
		};

		xserver.xkb = {
			layout = "us";
			variant = "";
		};

		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
		};

		auto-cpufreq.enable = true;
		auto-cpufreq.settings = {
			battery = {
				governor = "powersave";
				turbo = "never";
			};
			charger = {
				governor = "performance";
				turbo = "always";
			};
		};

		printing.enable = true;
		upower.enable = true;
		pulseaudio.enable = false;
		blueman.enable = true;

		gnome.gnome-keyring.enable = true;

		tailscale.enable = true;
		power-profiles-daemon.enable = false;
		fwupd.enable = true;
	};

d}
