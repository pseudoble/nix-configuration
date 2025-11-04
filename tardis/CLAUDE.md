# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal NixOS flake-based system configuration ("tardis") for a gaming/development/VR workstation. Manages both system-level (NixOS) and user-level (home-manager) configurations declaratively.

**Hardware**: Ryzen 9 3900X, RTX 4060 Ti 16GB, 64GB RAM
**Primary Use Cases**: VR streaming (Quest 2), game development, multi-language software development, AI/ML experimentation

## Quick Start Commands

### System Management
```bash
# Rebuild NixOS system
sudo nixos-rebuild switch
# or: osup (zsh alias)

# Rebuild home-manager
home-manager switch --flake ~/.pseudoble/tardis#cjosephs@nixos
# or: homeup (zsh alias)

# Update flake inputs
nix flake update

# Garbage collection (automatic weekly, keeps 30 days)
nix-collect-garbage --delete-older-than 30d
```

### Shell Aliases
- `osup` - Rebuild NixOS system
- `homeup` - Rebuild home-manager
- `nvim` - Launch Neovim from external flake (github:pseudoble/neovim-flake#standard)
- `ls` - Enhanced ls via exa with details
- `wo` / `br` - Pomodoro work/break timers
- `claude` / `gemini` / `codex` - AI CLI tools via yarn dlx

## Architecture

### Flake Structure
```
flake.nix                 # Main entry point
├── inputs
│   ├── nixpkgs          # nixos-unstable
│   └── home-manager     # follows nixpkgs
└── outputs
    ├── nixosConfigurations.nixos          # System config
    ├── homeConfigurations."cjosephs@nixos" # User config
    ├── overlays          # additions, modifications, unstable-packages
    ├── packages          # Custom packages
    └── devShells         # Bootstrap shell (nix, home-manager, git)
```

### Module Organization

**NixOS modules** (`nixos/configuration.nix` imports):
- `hardware-configuration.nix` - Auto-generated hardware config
- `bootloader.nix` - GRUB on /dev/nvme0n1
- `x11.nix` - NVIDIA drivers, i3 window manager
- `users.nix` - User accounts (cjosephs, minecraft)
- `network.nix` - NetworkManager, firewall rules
- `sound.nix` - PipeWire (PulseAudio/ALSA/JACK)
- `bluetooth.nix` - Bluetooth + Blueman
- `fonts.nix` - Font configuration
- `vr.nix` - VR stack (WiVRn, kernel patches, udev rules)

**Home-manager modules** (`home-manager/home.nix` imports):
- `zsh.nix` - Zsh + powerlevel10k + zoxide
- `tmux.nix` - Tmux with catppuccin theme
- `git.nix` - Git user configuration
- `i3.nix` - i3 window manager config
- `alacritty.nix`, `nushell.nix` - Terminal emulators
- `nvim.nix` - Neovim configuration
- `obs.nix` - OBS Studio with plugins
- `sunshine.nix` - **DISABLED** game streaming (causes system lockups)
- `vr.nix` - **COMMENTED OUT** OpenXR/OpenVR paths

### Overlay System
Applied to both NixOS and home-manager for consistency:
1. **additions** - Custom packages from `./pkgs`
2. **modifications** - Package overrides/patches (currently empty)
3. **unstable-packages** - Provides `pkgs.unstable` namespace

## VR Stack Architecture

### WiVRn Configuration (nixos/vr.nix)
OpenXR streaming runtime for Quest 2 wireless VR:
- **Default runtime**: Replaces Monado (explicitly disabled)
- **Auto-start**: Enabled with high priority
- **Firewall**: Automatically opened
- **Encoding**: VAAPI H.265 at 100 Mbps
- **Steam integration**: OpenXR runtime imports enabled

**Environment Variables**:
```bash
STEAMVR_LH_ENABLE=1           # Lighthouse tracking support
XRT_COMPOSITOR_COMPUTE=1      # GPU compute compositor
WMR_HANDTRACKING=0            # Disabled (not needed for Quest 2)
```

### Steam VR Launch Options
For Proton games to access WiVRn socket:
```
PRESSURE_VESSEL_FILESYSTEMS_RW=$XDG_RUNTIME_DIR/wivrn/comp_ipc %command%
```

### Custom Kernel Patch
AMD GPU high-priority context patch removes CAP_SYS_NICE requirement:
- **Purpose**: Enables async reprojection in Steam's bubblewrap sandbox
- **Source**: Frogging-Family community patches
- **Warning**: Removes kernel security restrictions, unsupported configuration

### OpenComposite
Allows running OpenVR games on OpenXR runtimes. Installed system-wide but home-manager paths currently commented out to prevent conflicts.

### Known VR Issues
- Old Proton versions may fail if OpenXR init fails
- Workaround: Delete `~/.config/openvr/openvrpaths.vrpath` and retry
- OpenComposite setup should be read-only to prevent SteamVR override

## Critical Safety Notes

### Boot Order Issue (UNRESOLVED)
System attempts to boot into old/broken Linux install on every startup. **Manual BIOS intervention required**.
- **Risk**: Could lose system access if GRUB misconfigured
- **Bootloader**: GRUB on /dev/nvme0n1 with OS Prober enabled
- **Status**: Tracked in todo.md #5

### Storage Crisis (ACTION NEEDED)
Root partition is **98% full** (only 20GB free on 1TB NVMe0).
- **Impact**: System instability, failed updates, build failures
- **Mitigation**: Move Steam library to /mnt/games (HDD with 1.2TB free) or use NVMe1 (unused)
- **Garbage collection**: Already enabled (weekly, 30 days retention)

### Configuration Safety
When making changes to NixOS configs:
1. Test incrementally - never make multiple breaking changes at once
2. Know rollback procedure: Reboot and select previous generation in GRUB menu
3. Verify system boots correctly after each change
4. Keep at least one known-good generation available

### State Version Warning
```nix
system.stateVersion = "23.05";  # NixOS
home.stateVersion = "23.05";    # home-manager
```
**DO NOT CHANGE** without reading documentation. This is for stateful data compatibility, not NixOS version.

## Known Issues

### Sunshine Service (DISABLED)
Game streaming service causes system lockups on startup. Comprehensively disabled:
- Service import commented in `home-manager/home.nix`
- Package commented in `home-manager/home.nix`
- Firewall rules (TCP/UDP 47984-48010) commented in `nixos/network.nix`
- All config in `home-manager/sunshine.nix` marked "DISABLED"

**Do not re-enable** without diagnosing root cause via boot logs (tracked in todo.md #3, #6).

## Development Workflow

### Planning and Task Management

This repository uses a structured workflow for managing changes:

1. **Planning Phase**: Add tasks to `todo.md` under "## Planning Phase"
   - Include detailed requirements and context for each task
   - Tasks are not in any particular order initially
   - Discuss and prioritize tasks before starting work

2. **Execution**: Work on one todo item at a time
   - Complete the task fully
   - Test and verify changes work as expected
   - Only mark as done when fully verified

3. **Documentation**: After completing a todo
   - Update `CHANGELOG.md` with changes and current date
   - Remove completed item from `todo.md` (or move to completed section)
   - Document what was done, why, and any relevant details

4. **Commit**: After documentation is updated
   - Stage all related changes
   - Commit with descriptive message following format below
   - Include both the changes and documentation updates in same commit

5. **Repeat**: Move to next todo item

This workflow ensures changes are tracked, documented, and safely applied incrementally.

### Adding Packages
**System-wide**: Add to `nixos/configuration.nix` environment.systemPackages
**User-level**: Add to `home-manager/home.nix` home.packages
**Preference**: Use home-manager for user tools, NixOS for services/drivers

### Creating Modules
Place reusable modules in:
- `modules/nixos/` for NixOS modules
- `modules/home-manager/` for home-manager modules

Import in respective configuration.nix or home.nix.

### Custom Packages
Define in `pkgs/default.nix`, automatically imported via overlays.additions.

### Testing Changes Safely
1. Make changes to one module at a time
2. Run `nixos-rebuild switch` or `homeup`
3. Verify functionality before next change
4. If boot fails, select previous generation in GRUB menu
5. Document changes in CHANGELOG.md

### Committing Changes
After completing todos:
1. Update CHANGELOG.md with changes and date
2. Update or remove completed items from todo.md
3. Commit with descriptive message following format:
   ```
   Brief summary of changes

   - Detailed change 1
   - Detailed change 2

   🤖 Generated with Claude Code
   Co-Authored-By: Claude <noreply@anthropic.com>
   ```

## Development Environment

### Language Toolchains
- **Scala**: scala-next, mill
- **Erlang/Gleam**: erlang_28, gleam
- **Go**: go, gopls (LSP)
- **.NET**: dotnetCorePackages.sdk_9_0-bin
- **Python**: python310 with jsonpickle
- **Node.js**: nodejs_22, yarn-berry
- **Java**: JDK 17 (user), JDK 21 (minecraft service)

### Editors
- **Neovim**: External flake (github:pseudoble/neovim-flake#standard), aliased as `nvim`
- **VSCode**: Installed via home-manager
- **JetBrains**: Toolbox for IDE management
- **Zed**: Modern alternative editor

### Shell Environment
- **Default shell**: Zsh with powerlevel10k theme
- **Directory navigation**: Zoxide (smart cd replacement)
- **Multiplexers**: Tmux (catppuccin theme), Zellij
- **Alternative shells**: Nushell configured

### AI/ML Setup
- **Ollama**: Service with CUDA acceleration
- **CUDA toolkit**: cudaPackages.cudatoolkit
- **Cachix**: ai.cachix.org trusted for binary cache

## Services

### Enabled System Services
- **libvirtd**: Virtualization (QEMU/KVM)
- **ollama**: AI model inference (CUDA enabled)
- **openssh**: Remote access (no root login)
- **flatpak**: Universal app support
- **avahi**: mDNS for network printer discovery
- **wivrn**: VR streaming runtime

### User Services
- **picom**: Compositor for i3
- **blueman-applet**: Commented out (bluetooth management)

## Firewall Configuration

### Open Ports
- **TCP**: 7777, 4455, 25565
- **UDP**: 9944, 7777, 25565, 47998, 47999
- **WiVRn**: Automatically opened by service
- **Sunshine ports**: Currently commented out (47984-48010 TCP/UDP)

### Port Usage
- 25565: Minecraft server
- 7777: Game server (dual TCP/UDP)
- 4455: Unknown service
- 9944: Unknown UDP service
- 47998-47999: Legacy VR streaming ports

## Common Tasks

### Update System
```bash
cd ~/.pseudoble/tardis
nix flake update              # Update flake.lock
sudo nixos-rebuild switch     # Apply system changes
homeup                        # Apply user changes
```

### Clean Up Storage
```bash
nix-collect-garbage --delete-older-than 7d  # More aggressive than auto GC
nix-store --gc                              # Remove unreferenced paths
nix-store --optimize                        # Deduplicate (auto-enabled)
```

### Check System Status
```bash
nixos-version                 # Current NixOS version
home-manager --version        # Home-manager version
nix flake metadata            # Show flake info
nix profile history           # Show generations
```

### Rollback
```bash
# List generations
nix profile history --profile /nix/var/nix/profiles/system

# Rollback system
sudo nix-env --rollback --profile /nix/var/nix/profiles/system
sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch

# Or: Select previous generation in GRUB menu on boot
```

## udev Rules

### VR Devices
- Valve Index controllers (vendor 28de)
- Meta Quest 2 (vendor 2833, multiple product IDs)
- All hidraw devices: MODE="0666"

### Other Devices
- Vial keyboard configurator support
- uinput: Virtual input device creation (GROUP="input")

## Notes

- **External Neovim**: Config managed in separate flake, not this repo
- **Gaming**: Steam library can use /mnt/games (HDD) for additional space
- **Minecraft server**: System user with dedicated JDK 21 and /var/minecraft directory
- **NixOS state**: 23.05 (do not change without reading docs)
- **Git repo**: git@github.com:pseudoble/nix-configuration.git
