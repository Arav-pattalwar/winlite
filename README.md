# WinLite

A lightweight Linux-based OS (Debian 12 + Xfce) styled after Windows 11. It is
a live-build recipe: you build the ISO yourself.

| Your request | What WinLite does |
|---|---|
| Looks like Windows 11 | Fluent GTK theme + icons, bottom taskbar, Windows-style buttons (close to, not identical) |
| One core, 4 GB RAM | Xfce, no compositor, zram, earlyoom, trimmed services (~500 MB idle) |
| Old processors | `ARCH=i386` builds a 32-bit image for pre-x86-64 CPUs |
| Runs .exe | Wine, double-click `.exe` / `.msi` |
| Chrome preinstalled | Google Chrome (amd64) / Chromium (i386) |
| Office preinstalled | LibreOffice (opens .docx/.xlsx/.pptx) + Word/Excel/PowerPoint web shortcuts. Desktop Microsoft Office is licensed, so it can't be bundled; install your own copy via Wine |
| No Copilot | No AI assistant or telemetry is installed |
| NT kernel | Dropped as agreed. This uses the Linux kernel |

## Build (needs Debian/Ubuntu or WSL2 Debian, ~15 GB free, root)

```bash
cd WinLite
chmod +x build.sh config/hooks/live/*.chroot config/includes.chroot/usr/local/bin/*
sudo ./build.sh              # 64-bit
sudo ARCH=i386 ./build.sh    # 32-bit, very old CPUs
```

Write the resulting `.iso` to a USB drive with Rufus or balenaEtcher, or test it in
VirtualBox with 1 CPU and 4 GB RAM.

## Limits
- Not tested: I could not build the ISO in this environment, so expect to fix small
  build errors on the first run.
- Wine runs many, not all, Windows programs. Modern Office desktop versions are hit and miss.
- Modern Chrome on a single old core will feel slow regardless of OS.
