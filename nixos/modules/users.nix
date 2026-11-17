{ pkgs, ... }:
{
	users.groups.gamemode = {};

	users.users.kax = {
		isNormalUser = true;
		shell = pkgs.zsh;
		description = "kax";
		extraGroups = [ "networkmanager" "wheel" "dialout" "docker" "input" "gamemode"];
	};
}
