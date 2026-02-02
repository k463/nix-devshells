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
          packages = with pkgs; [
            self'.packages.default
          ];
        };
        devShells.godev = pkgs.mkShell {
          # packages needed for building the software in this repo
          nativeBuildInputs = with pkgs; [
            go
          ];
          # packages needed at runtime for running software in this repo
          packages = with pkgs; [
            self'.packages.godev
          ];
        };
        devShells.infra = pkgs.mkShell {
          # packages needed for building the software in this repo
          nativeBuildInputs = with pkgs; [];
          # packages needed at runtime for running software in this repo
          packages = with pkgs; [
            self'.packages.infra
          ];
        };
        devShells.k8s = pkgs.mkShell {
          # packages needed for building the software in this repo
          nativeBuildInputs = with pkgs; [
            kubebuilder
          ];
          # packages needed at runtime for running software in this repo
          packages = with pkgs; [
            self'.packages.k8s
          ];
        };
        devShells.temporaldev = pkgs.mkShell {
          # packages needed for building the software in this repo
          nativeBuildInputs = with pkgs; [
            go
          ];
          # packages needed at runtime for running software in this repo
          packages = with pkgs; [
            self'.packages.temporaldev
          ];
        };

        packages.default = pkgs.buildEnv {
          name = "nix-devshells";
          paths = with pkgs; [];
        };
        packages.godev = pkgs.buildEnv {
          name = "nix-devshells";
          paths = with pkgs; [
            # https://mgdm.net/weblog/vscode-nix-go-tools/
            go
            gotools
            gopls
            go-outline
            gopkgs
            gocode-gomod
            godef
            golint
          ];
        };
        packages.infra = pkgs.buildEnv {
          name = "nix-devshells-infra";
          paths = with pkgs; [
            aws-sso-cli
            awscli2
            awsls
            checkov
            curl
            opentofu
            python3
            terraform
            terraform-docs
            terraform-ls
            terraformer
            tflint
            tofu-ls
            wget
          ];
        };
        packages.k8s = pkgs.buildEnv {
          name = "nix-devshells";
          paths = with pkgs; [
            # kubernetes tools
            cilium-cli
            clusterctl
            cmctl
            ctlptl
            jq
            k9s
            kdash
            kind
            kube-capacity
            kube-linter
            kubebuilder
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
            kubie
            kustomize
            kuttl
            popeye
            stern
            tilt
            yq-go
          ] ++ lib.optionals (lib.strings.hasPrefix "x86_64" pkgs.stdenv.hostPlatform.system) (with pkgs; [
            click
          ]);
        };
        packages.temporaldev = pkgs.buildEnv {
          name = "nix-devshells";
          paths = with pkgs; [
            self'.packages.godev
            temporal-cli
          ];
        };
      };
    };
}
