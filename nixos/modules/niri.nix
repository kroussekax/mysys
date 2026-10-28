{pkgs, ...}:
let
  niri-tablet-src = pkgs.fetchFromGitHub {
    owner = "GGEZUS";
    repo = "niri-tablet";
    rev = "v26.04.18";
    hash = "sha256-yceNeLKcv7HNc2UxkP+Ka1oa9Zx96OhYUvlESzYVI3s=";
  };

  niri-tablet = pkgs.niri.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      for patch_file in ${niri-tablet-src}/pkg/*.patch; do
        patch -Np1 < "$patch_file"
      done
    '';
  });
in
{
	programs.niri = {
		enable = true;
		package = niri-tablet;
	};
}
