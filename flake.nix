{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";
    # default = Darwin+Linux+x86+ARM, or default-linux, default-darwin, etc.
    # see https://github.com/nix-systems/
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs@{ flake-parts, systems, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = (import systems);
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devShells.default = pkgs.mkShell {
          # packages needed for building the software in this repo
          nativeBuildInputs = with pkgs; [];
          # packages needed at runtime for running software in this repo
          packages = with pkgs; [];
        };
        devShells.godev = pkgs.mkShell {
          # packages needed for building the software in this repo
          nativeBuildInputs = with pkgs; [
            go
          ];
          # packages needed at runtime for running software in this repo
          packages = with pkgs; [
            gopls
          ];
        };
        devShells.k8s = pkgs.mkShell {
          # packages needed for building the software in this repo
          nativeBuildInputs = with pkgs; [
            kubebuilder
          ];
          # packages needed at runtime for running software in this repo
          packages = with pkgs; [
            # kubernetes tools
            cilium-cli
            clusterctl
            cmctl
            ctlptl
            k9s
            kdash
            kind
            kube-capacity
            kube-linter
            kubeconform
            kubectl
            kubectl-gadget
            kubectl-ktop
            kubectl-tree
            kubernetes-helm
            kubernetes-helmPlugins.helm-unittest
            kubesec
            kubespy
            kubetui
            kustomize
            kuttl
            popeye
            stern
            tilt
          ] ++ lib.optionals (lib.strings.hasPrefix "x86_64" pkgs.stdenv.hostPlatform.system) (with pkgs; [
            click
          ]);
        };
        devShells.temporaldev = pkgs.mkShell {
          # packages needed for building the software in this repo
          nativeBuildInputs = with pkgs; [
            go
          ];
          # packages needed at runtime for running software in this repo
          packages = with pkgs; [
            gopls
            temporal-cli
          ];
        };
      };
    };
}
