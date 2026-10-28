{ pkgs, ...}:
{
	programs.appimage = {
		enable = true;
		binfmt = true;
	};

	environment.systemPackages = with pkgs; [
		home-manager
		efibootmgr

		bibata-cursors

		polkit_gnome
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
}
