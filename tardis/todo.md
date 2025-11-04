# TODO

## Planning Phase

### 1. Diagnose system lockup when sunshine starts
- Look through bootup logs to identify issues that may contribute to system locking up when sunshine starts

### 4. Cleanup and organize nix configs SAFELY
- Reorganize and cleanup nix configuration files
- SAFETY REQUIREMENTS:
  - Ensure system boots correctly after changes
  - Have a well-defined contingency plan if boot fails
  - Educate on recovery procedures (bootloader rollback, etc.)
  - Test incrementally to minimize risk

### 5. Fix boot order issue
- System tries to boot into old/broken Linux install on startup
- Currently requires manual BIOS intervention to boot correctly
- Need to fix boot order or remove old bootloader entries

### 6. Reinstall and fix sunshine
- Reinstall sunshine after disabling it
- Ensure it functions normally without causing system lockups

### 7. Make osup use flake like homeup
- Update zsh.nix to make osup use the flake: `sudo nixos-rebuild switch --flake ~/.pseudoble/tardis#nixos`
- Currently just uses `sudo nixos-rebuild switch` without flake specification

### 8. Get Quest 2 VR headset working with Steam
- Diagnose and fix Quest 2 connectivity with Steam VR on this PC
- Test wireless streaming (WiVRn) and/or wired connection
- Verify Steam VR launches and detects headset
- Test with at least one VR game to confirm functionality

---

