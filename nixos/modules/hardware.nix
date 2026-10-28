{pkgs, ...}:
{
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
}
