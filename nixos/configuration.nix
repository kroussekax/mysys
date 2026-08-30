{ config, pkgs, inputs, ... }:

{
	imports = [
		./hardware-configuration.nix
		./modules
	];

	nix.settings.experimental-features = ["nix-command" "flakes"];
	nixpkgs.config.allowUnfree = true;

	nixpkgs.overlays = [
		inputs.nix-cachyos-kernel.overlays.default
	];

	time.timeZone = "Asia/Jakarta";
	i18n.defaultLocale = "en_US.UTF-8";

	xdg.portal.enable = true;

	virtualisation.docker.enable = true;

	environment.systemPackages = with pkgs; [
		home-manager
		efibootmgr

		zsh
		nix-ld

		inputs.iio-hyprland.packages.${pkgs.system}.default

		bibata-cursors

		polkit_gnome

		(catppuccin-sddm.override {
		 flavor = "mocha";
		 accent = "mauve";
		 background = "${../wallpaper.png}";
		 loginBackground = true;
		})

		(inputs.pixie-sddm.packages.${pkgs.stdenv.hostPlatform.system}.pixie-sddm.override {
		 background = "${../wallpaper.png}";
		 avatar = ../avatar.jpeg;       
		 primaryColor = "#B3C8FF";      
		 accentColor = "#3F5F91";      
		 autoColor = true;            
		 backgroundColor = "#1A1C1E";      
		 textColor = "#E2E2E6";           
		 fontFamily = "JetBrains Mono";  
		 fontSize = 13;                 
		})

		vulkan-tools

		os-prober
		xdg-desktop-portal-gtk
		inotify-tools
		app2unit
		trash-cli
		btop
		papirus-icon-theme
		kdePackages.qt5compat
		nerd-fonts.jetbrains-mono
		];

		system.stateVersion = "25.11";
}
