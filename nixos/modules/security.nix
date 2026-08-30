{ config, ...}:
{
	security = {
		pam.services.login.enableGnomeKeyring = true;
		pam.services.gdm.enableGnomeKeyring = true;
		pam.u2f.enable = true;
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
