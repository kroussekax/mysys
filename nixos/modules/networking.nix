{ ... }:
{
	networking = {
		hostName = "est";
		networkmanager.enable = true;
		firewall = {
			allowedTCPPortRanges = [
			{
				from = 1714;
				to = 1764;
			}
			];
			allowedTCPPorts = [
				3000
				53317
				8191
				19132
				3312
				8080
			];
			allowedUDPPorts = [
				53317
				1716
				8191
				19132
				3312
			];
		};
		nameservers = [
			"8.8.8.8"
			"1.1.1.1"
			"1.0.0.1"
		];
	};
}
