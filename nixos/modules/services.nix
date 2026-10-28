{ pkgs, ...}:
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

		openssh = {
			enable = true;
			openFirewall = true;
			settings = {
				PasswordAuthentication = true;
				KbdInteractiveAuthentication = false;
				PermitRootLogin = "no";
				AllowUsers = [ "kax" ];
				MaxAuthTries = 3;
				PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
			};
		};

		udisks2.enable = true;
		gvfs.enable = true;

		xserver.enable = true;

		flatpak.enable = true;

		displayManager.sddm = {
			enable = false;
			theme = "pixie";
			wayland.enable = true;

			package = pkgs.kdePackages.sddm;

			extraPackages = [
				pkgs.kdePackages.qtsvg
				pkgs.kdePackages.qtdeclarative
				pkgs.kdePackages.qt5compat
			];
		};

		greetd = {
			enable = true;

			settings = {
				default_session = {
					command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
					user = "greeter";
				};
			};
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

		auto-cpufreq.enable = false;
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
		power-profiles-daemon.enable = true;
		fwupd.enable = true;

		desktopManager.gnome.enable = true;

		gnome = {
			core-apps.enable = false;
			core-developer-tools.enable = false;
			games.enable = false;
		};

	};
}
