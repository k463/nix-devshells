# nix-devshells

My (opinionated) nix dev shells flake for various projects that do not have
their own custom dev shall configuration. For use with `nix develop`, etc.

Using:

- [flake-parts](https://github.com/hercules-ci/flake-parts)
- [flakehub](https://flakehub.com/)

## shells

- `default`: empty
- `godev`: [Go](https://go.dev/) language dev; includes Go itself and language
  server (`gopls`)
- `temporaldev`: [Temporal](https://temporal.io/) + Go development

## usage

List available shells:

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
nix develop --profile ~/.local/state/nix-devshell-profiles/k463.nix-devshells.foo github:k463/nix-devshells#foo
```
