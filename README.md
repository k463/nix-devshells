# nix-devshells

My (opinionated) nix dev shells flake for various projects that do not have
their own custom dev shall configuration. For use with `nix develop`, etc.

Using:

- [flake-parts](https://github.com/hercules-ci/flake-parts)
- [flakehub](https://flakehub.com/)

## shells

- ``:

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
