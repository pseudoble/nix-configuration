# Boot Health Report – 2025-11-04

## Inputs Reviewed
- `journalctl -b --priority=3` for current boot errors and warnings.
- `journalctl -b | rg '(nvidia|bluetooth|monado)'` to track GPU and VR stack events.
- Sunshine and WiVRn logs (`journalctl -b | rg 'sunshine|wivrn'`) returned no entries in this boot.

## Observations
- **IOMMU warning persists** – `iommu ivhd0` still reports `INVALID_DEVICE_REQUEST` for PCI `0000:00:00.0`; typically benign unless you rely on device passthrough.
- **amd_pstate disabled successfully** – Boot no longer logs CPPC errors; frequency scaling now uses `acpi-cpufreq` without spam.
- **USB audio negotiation issue** – `usb 1-3: cannot get freq at ep 0x84` still appears; this is the Microdia webcam’s audio interface trying unsupported sample rates.
- **Resolved items** – Plugdev, CUPS, GNOME keyring, Monado, Sunshine warnings remain cleared.
- **NVIDIA driver stable** – No startup errors; udev helper still returns non-zero while creating `/dev/nvidia*`, but devices work.

## Recommended Follow-ups
1. Decide whether to ignore the Microdia webcam audio warning or remove/blacklist the device if it is unused.
2. Optionally review the NVIDIA udev helper exit status to ensure device nodes are created as expected.
3. After any adjustment, rerun `journalctl -b --priority=3` to ensure the boot stays clean.
