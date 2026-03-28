{ config, pkgs, inputs, ... }:

{
	imports = [
		./hardware-configuration.nix
	];

	nixpkgs.overlays = [
		inputs.nix-cachyos-kernel.overlays.default
	];

	boot = {
		loader = {
			efi.canTouchEfiVariables = true;
			grub = { 
				enable = true;
				device = "nodev";
				useOSProber = true;
				efiSupport = true;
				theme = pkgs.stdenv.mkDerivation {
					name = "minegrub";
					src = pkgs.fetchFromGitHub {
						owner = "Lxtharia";
						repo = "minegrub-theme";
						rev = "main";
						sha256 = "1lv9wsam2lccidyyr4alm7d10jycsgi26bgijxnjdzjci8041y8s";
					};
					installPhase = "cp -r minegrub $out";
				};
			};
		};
		kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
	};

	networking = {
		hostName = "est";
		networkmanager.enable = true;
		firewall = {
			allowedTCPPorts = [
				3000
					53317
					8191
			];
			allowedUDPPorts = [
				53317
					8191
			];
		};
		nameservers = [
			"1.1.1.1"
				"1.0.0.1"
		];
	};

	time.timeZone = "Asia/Jakarta";
	i18n.defaultLocale = "en_US.UTF-8";

	nix.settings.experimental-features = ["nix-command" "flakes"];

	boot.kernelModules = [
		"industrialio"
			"industrialio_triggered_buffer"
			"kxcjk1013"
			"bmi160"
	];

	services = {
		udev.extraRules = ''
			KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
			'';

		udev.packages = with pkgs; [
			platformio-core.udev
				pkgs.iio-sensor-proxy
		];

		xserver.enable = true;

		displayManager.sddm = {
			enable = true;

			theme = "catppuccin-mocha-mauve";
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
		flatpak.enable = true;

		gnome.gnome-keyring.enable = true;
	};

	security = {
		pam.services.login.enableGnomeKeyring = true;
		pam.services.gdm.enableGnomeKeyring = true;
		rtkit.enable = true;
		polkit.enable = true;
	};

	hardware = {
		graphics = {
			enable = true;
			enable32Bit = true;

			extraPackages = with pkgs; [
				mesa
			];
			extraPackages32 = with pkgs.pkgsi686Linux; [
				mesa
			];
		};

		sensor.iio.enable = true;

		bluetooth = {
			enable = true;
			powerOnBoot = true;
		};

		keyboard.qmk.enable = true;
	};


	users.users.kax = {
		isNormalUser = true;
		shell = pkgs.zsh;
		description = "kax";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
		];
	};


	programs = {
		zsh.enable = true;
		firefox.enable = true;
		hyprland.enable = true;
		nix-ld.enable = true;
	};

	environment.variables = {
		XCURSOR_THEME = "Bibata-Modern-Ice";
		XCURSOR_SIZE = "24";
	};

	xdg.portal.enable = true;
	xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

	nixpkgs.config.allowUnfree = true;
	environment.systemPackages = with pkgs; [
		home-manager
			efibootmgr

			inputs.iio-hyprland.packages.${pkgs.system}.default

			bibata-cursors

			flatpak
			catppuccin-sddm

			vulkan-tools

			os-prober

			xdg-desktop-portal-hyprland
			xdg-desktop-portal-gtk
			hyprpicker
			inotify-tools
			app2unit
			wireplumber
			trash-cli
			starship
			btop
			htop
			jq
			eza
			papirus-icon-theme
			kdePackages.qt5compat
			nerd-fonts.jetbrains-mono
			];

	system.stateVersion = "25.11";

}
