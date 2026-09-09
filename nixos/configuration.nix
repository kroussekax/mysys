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

	programs = {
		zsh.enable = true;
		nix-ld.enable = true;
	};


		system.stateVersion = "25.11";
}
