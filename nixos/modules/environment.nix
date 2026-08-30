{config, ...}:
{
	environment = {
		variables = {
			XCURSOR_THEME = "Bibata-Modern-Ice";
			XCURSOR_SIZE = "24";

		};

		gnome.excludePackages = with pkgs; [
			gnome-tour
			epiphany
			geary
			totem
			yelp
			simple-scan
			gnome-music
			gnome-photos
			gnome-weather
			gnome-connections
			gnome-characters
			gnome-console
			gnome-text-editor
			baobab
			evince
			seahorse
			nautilus
		];

	};
}
