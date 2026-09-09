{config, pkgs, ...}:
{
	users.users.kax = {
		isNormalUser = true;
		shell = pkgs.zsh;
		description = "kax";
		extraGroups = [ "networkmanager" "wheel" "dialout" "docker"];
	};
}
