{
  description = "gt-curriculum: GT + TopicMaps + Repomix tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";

    # Reuse your repomix-tools flake
    # Use one of:
    # - a local path
    # - or a GitHub repo if you push it
    repomix-tools.url = "path:../repomix-tools";
    # repomix-tools.url = "github:ralfbarkow/repomix-tools";

    # Make nixpkgs/flake-utils consistent
    repomix-tools.inputs.nixpkgs.follows = "nixpkgs";
    repomix-tools.inputs.flake-utils.follows = "flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, repomix-tools }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        # Your project dev shell, *including* repomix tools
        devShells.default = pkgs.mkShell {
          # pull in everything from repomix-tools devShell
          inputsFrom = [
            repomix-tools.devShells.${system}.default
          ];

          # Plus any extra tools you want for gt-curriculum
          packages = [
            pkgs.git
            pkgs.nodejs_20
            # add others here (codex, pandoc, etc. if you package them)
          ];

          shellHook = ''
            echo "gt-curriculum dev shell"
            echo "Repomix tools are available:"
            echo "  repomix-md, repomix-remote"
          '';
        };

        # Optionally re-expose repomix apps under this flake too:
        apps = {
          repomix-md = repomix-tools.apps.${system}.repomix-md;
          repomix-remote = repomix-tools.apps.${system}.repomix-remote;
        };
      });
}
