{ ... }:
{
	security = {
		pam = {
			u2f.enable = true;
			services = {
				login.enableGnomeKeyring = true;
				gdm.enableGnomeKeyring = true;
				sudo.fprintAuth = true;
				login.fprintAuth = true;
			};

		};
		rtkit.enable = true;

		polkit.enable = true;
		polkit.extraConfig = ''
			polkit.addRule(function(action, subject) {
					if (action.id == "org.freedesktop.systemd1.soft-reboot" &&
							subject.isInGroup("wheel")) {
					return polkit.Result.YES;
					}
					});
		'';
	};
}
