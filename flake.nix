{
	description = "Main Nix Flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

		iio-hyprland.url = "github:JeanSchoeller/iio-hyprland";
	};

	outputs = { self, nixpkgs, ... } @ inputs:
		let
		system = "x86_64-linux";

		pkgs = import nixpkgs {
			inherit system;

			config = {
				allowUnfree = true;
			};
		};
	in
	{
		nixosConfigurations.est = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit system inputs; };
			modules = [
				./nixos/configuration.nix
			];
		};
	};
}
