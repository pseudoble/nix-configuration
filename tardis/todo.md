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

---

