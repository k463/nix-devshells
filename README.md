# nix-devshells

My (opinionated) nix dev shells flake for various projects that do not have
their own custom dev shall configuration. For use with `nix develop`, etc.

Most dev shells are based on path packages built using `pkgs.buildEnv` which
produces an object (directory) in the Nix store with FHS-like structure with
links to files in individual packages. This has the advantage that only 1
directory has to be added to PATH-like variables, instead of 1 per package, and
also it makes it easier to use in situations where you want to use that dev env
in configuration of some program like an IDE.

Since these are just regular packages they can also be used with `nix shell`
(if you don't need a build environment like compilers, etc.).

Using:

- [flake-parts](https://github.com/hercules-ci/flake-parts)
- [flakehub](https://flakehub.com/)

## packages / shells

- `default`: empty
- `godev`: [Go](https://go.dev/) language dev; includes Go itself, language
  server (`gopls`), and other tools like linter, etc.
- `k8s`: [Kubernetes](https://kubernetes.io/) tools for cluster administration
  and app/service manifest development
- `temporaldev`: [Temporal](https://temporal.io/) + Go development

## usage

Replace `foo` with one of the available devshells.

List available packages and shells:

``` sh
nix flake show github:k463/nix-templates
```

Start bash with environment and packages defined in `foo` devshell:

``` sh
nix develop github:k463/nix-devshells#foo
```

Start fish with environment and packages defined in `bar` devshell:

``` sh
nix develop github:k463/nix-devshells#bar --command fish -l
```

Start bash with `foo` devshell, saving the environment in a profile for faster
re-launching later:

``` sh
nix develop \
  --profile ~/.local/state/nix-devshell-profiles/k463.nix-devshells.foo \
  github:k463/nix-devshells#foo
```

Start a regular shell in environment of `foo` devshell:

``` sh
nix shell github:k463/nix-devshells#foo
```

Build a package containing environment for shell `foo`, and save a link to it in
`~/.local/state/nix-devshell-envs/` directory, use a profile:

``` sh
nix build \
  --out-link ~/.local/state/nix-devshell-envs/k463.nix-devshells.foo \
  --profile ~/.local/state/nix-devshell-profiles/k463.nix-devshells.foo \
  github:k463/nix-devshells#foo
ls -lhA ~/.local/state/nix-devshell-envs/k463.nix-devshells.foo/bin/
ls -lhA ~/.local/state/nix-devshell-envs/k463.nix-devshells.foo/share/
```
