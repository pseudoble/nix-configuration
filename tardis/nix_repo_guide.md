# NixOS + Home-Manager Repository Guide

This repo is organized around three ideas:

1.  **One flake, many systems/users.**\
    Hosts and users simply *compose modules*.

2.  **Separate what from where.**\
    "What" = reusable modules.\
    "Where" = thin host/user configs that import modules.

3.  **Group by concern, not by random files.**\
    Prefer `services/`, `desktop/`, `cli/`, etc. over per-app clutter.

------------------------------------------------------------------------

## Top-Level Layout

    .
    ├── flake.nix
    ├── flake.lock
    ├── lib/                  # small helpers / utilities
    ├── pkgs/                 # custom packages & overlays
    │   ├── overlay.nix
    │   └── <pkg>.nix
    ├── overlays/             # optional: multiple overlays
    ├── nixos/
    │   ├── hosts/            # host definitions (thin!)
    │   │   ├── desktop/
    │   │   │   ├── default.nix
    │   │   │   └── hardware-configuration.nix
    │   │   └── laptop/
    │   │       ├── default.nix
    │   │       └── hardware-configuration.nix
    │   └── modules/          # reusable system modules
    │       ├── core/
    │       │   ├── boot.nix
    │       │   ├── fonts.nix
    │       │   ├── packages.nix
    │       │   └── users.nix
    │       ├── services/
    │       │   ├── ssh.nix
    │       │   ├── tailscale.nix
    │       │   └── prometheus.nix
    │       └── desktop/
    │           ├── i3.nix
    │           └── sway.nix
    └── home/
        ├── users/            # user configs (thin!)
        │   ├── pseudoble-desktop.nix
        │   └── pseudoble-laptop.nix
        └── modules/          # reusable HM modules
            ├── cli.nix
            ├── dev.nix
            ├── editors.nix
            ├── shell.nix
            └── desktop/
                ├── i3.nix
                └── gtk-theme.nix

------------------------------------------------------------------------

## Roles of Each Piece

### `flake.nix`

-   Declares inputs (nixpkgs, home-manager, sops-nix, etc.)
-   Loads overlays
-   Exposes:

```{=html}
<!-- -->
```
    nixosConfigurations.<host>
    homeConfigurations.<user>@<host>

Everything else plugs into this.

------------------------------------------------------------------------

### `nixos/modules/**`

> **Rule:** modules are reusable and host-agnostic.

Put system concerns here:

-   boot, networking, fonts, packages
-   services (ssh, tailscale, prometheus...)
-   desktops (i3, sway)

Avoid hostnames, user names, or machine-specific values in modules.

------------------------------------------------------------------------

### `nixos/hosts/<host>/default.nix`

> **Rule:** thin files that compose modules.

Typical pattern:

``` nix
{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core
    ../../modules/services/ssh.nix
    ../../modules/desktop/i3.nix
  ];

  networking.hostName = "HOSTNAME";
  system.stateVersion = "24.11";
}
```

Only add overrides that are truly host-specific.

------------------------------------------------------------------------

### `home/modules/**`

> **Rule:** platform-agnostic user features.

Examples:

-   CLI tools
-   editor setup
-   shells
-   i3/GTK theming
-   dev toolchains

Do **not** define `home-manager.users.*` here.\
Keep them reusable across multiple systems --- even macOS or non-NixOS.

------------------------------------------------------------------------

### `home/users/*.nix`

> **Rule:** thin glue layer per user + host.

Example:

``` nix
{ pkgs, ... }: {
  imports = [ ../modules ];
  home.username = "pseudoble";
  home.homeDirectory = "/home/pseudoble";
  home.stateVersion = "24.11";
}
```

------------------------------------------------------------------------

## Custom Packages & Overlays

Keep personal packages isolated:

    pkgs/
    overlays/

The flake imports overlays once and passes them through everywhere.

Avoid sprinkling inline overlays inside host or home modules.

------------------------------------------------------------------------

## Granularity Guidelines

Prefer functional groupings:

-   `desktop/i3.nix`
-   `services/ssh.nix`
-   `core/fonts.nix`
-   `dev.nix`
-   `cli.nix`

Avoid excessive micro-files unless something is complex enough to
deserve it.

Bad smell:

    git.nix
    ripgrep.nix
    htop.nix

Those belong together in a broader "cli tools" module.

------------------------------------------------------------------------

## Using Home-Manager Both Inside and Outside NixOS

Keep HM modules generic.

You can wire them either:

**Inside NixOS**

``` nix
home-manager.users.pseudoble = import ./home/users/pseudoble-desktop.nix;
```

**Standalone**

``` nix
homeConfigurations."pseudoble@host" =
  home-manager.lib.homeManagerConfiguration {
    modules = [ ./home/users/pseudoble-desktop.nix ];
  };
```

Same module tree --- two entry points.

------------------------------------------------------------------------

## Refactoring Checklist

1.  Create folders:

```{=html}
<!-- -->
```
    nixos/hosts
    nixos/modules/core
    home/users
    home/modules
    pkgs

2.  Move big chunks from `configuration.nix` into `nixos/modules/*`.

3.  Turn each previous "section" into a module:

-   boot
-   users
-   fonts
-   desktop
-   networking
-   services

4.  Create a thin host file that imports those.

5.  Split `home.nix` into shared modules + thin user files.

6.  Wire everything in `flake.nix`.

------------------------------------------------------------------------

## Goals

This structure aims for:

-   small, readable host files
-   reusable features
-   clean separation of system vs user vs packaging
-   easy addition of new hosts/users
-   no more giant monolithic configs
