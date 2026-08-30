{config, ...}:
{
	boot = {
		loader = {
			efi.canTouchEfiVariables = true;
			grub = {
				enable = true;
				device = "nodev";
				useOSProber = true;
				efiSupport = true;
			};
		};
		kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore;
		kernelParams = [
			"mem_sleep_default=deep"
		];
		kernel.sysctl = {
			"user.max_user_namespaces" = 1048576;
		};

		kernelModules = [
			"industrialio"
			"industrialio_triggered_buffer"
			"kxcjk1013"
			"bmi160"
			"v4l2loopback"
		];

		extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

		extraModprobeConfig = ''
			options v4l2loopback devices=1 video_nr=10 card_label="Virtual Camera" exclusive_caps=1
			'';
	};
}
