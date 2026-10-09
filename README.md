# Noctalia Legacy v4

> [!NOTE]
> This is a **community-maintained fork of Noctalia v4**, based on upstream's [`legacy-v4`](https://github.com/noctalia-dev/noctalia/tree/legacy-v4) branch (last upstream release: v4.7.7).
> Upstream no longer develops or supports v4. This fork only keeps v4 running on current Arch Linux (mainly Qt updates). It does **not** add new features.
>
> Please report problems with this fork **here**, not to the upstream Noctalia project.
> If you are starting fresh, consider [Noctalia v5](https://docs.noctalia.dev/noctalia/getting-started/installation/), which is actively maintained upstream.

**_quiet by design_**

<p align="center">
  <img src="https://assets.noctalia.dev/noctalia-logo.svg?v=2" alt="Noctalia Logo" style="width: 192px" />
</p>

<p align="center">
  <a href="https://aur.archlinux.org/packages/noctalia-legacy-v4">
    <img src="https://img.shields.io/aur/version/noctalia-legacy-v4?style=for-the-badge&labelColor=0C0D11&color=A8AEFF&logo=archlinux&logoColor=FFFFFF&label=AUR" alt="AUR version" />
  </a>
  <a href="https://github.com/DBeidachazi/noctalia-shell/commits/legacy-v4">
    <img src="https://img.shields.io/github/last-commit/DBeidachazi/noctalia-shell/legacy-v4?style=for-the-badge&labelColor=0C0D11&color=A8AEFF&logo=git&logoColor=FFFFFF&label=commit" alt="Last commit" />
  </a>
</p>

---

## Changes compared to upstream v4.7.7

- **Qt 6.12 compatibility.** Qt 6.12 adds a built-in `QtQuick/Color` singleton that shadows Noctalia's own `Color` singleton. Under Qt 6.12, every `Color.*` call resolved to Qt's type, so all colors became `undefined` and the UI lost its styling (log: `Property 'resolveColorKey' of object QQuickColor is not a function`). All `import QtQuick` / `import QtQuick.Window` statements are now pinned to `6.11`, which hides the new singleton.
- The About page checks this fork for new releases instead of upstream, so it no longer suggests "updating" to v5.
- Uses the community-maintained [noctalia-qs fork](https://github.com/DBeidachazi/noctalia-qs) (0.0.13+), which builds with Qt 6.12.
- Removed upstream-only CI workflows, including the one that auto-closed every v4 issue.

---

## 📦 Installation

### Arch Linux (AUR)

```bash
yay -S noctalia-legacy-v4   # or paru -S noctalia-legacy-v4
```

The package installs to `/etc/xdg/quickshell/noctalia-shell`, the same path as the old `noctalia-shell` package. It therefore **replaces** `noctalia-shell` (they conflict). Your existing configuration in `~/.config/noctalia` keeps working unchanged. Start it as before:

```bash
qs -c noctalia-shell
```

The AUR package is built from [`packaging/aur/PKGBUILD`](./packaging/aur/PKGBUILD) in this repository.

### Manual installation

Install [noctalia-qs](https://github.com/DBeidachazi/noctalia-qs) (AUR: `noctalia-qs`), then:

```bash
git clone -b legacy-v4 https://github.com/DBeidachazi/noctalia-shell ~/.config/quickshell/noctalia-shell
qs -c noctalia-shell
```

### Third-party v4 plugins

Plugins in `~/.config/noctalia/plugins` hit the same Qt 6.12 `Color` clash if they use `Color.*` together with a plain `import QtQuick`. Pin their imports in the same way:

```bash
find ~/.config/noctalia/plugins -name '*.qml' -exec sed -i -E \
  's/^(\s*)import QtQuick\s*$/\1import QtQuick 6.11/; s/^(\s*)import QtQuick\.Window\s*$/\1import QtQuick.Window 6.11/' {} +
```

Note that the plugin manager may overwrite these edits when it updates a plugin.

---

## 📋 Requirements

- Wayland compositor (see supported compositors below)
- Quickshell: [noctalia-qs](https://github.com/DBeidachazi/noctalia-qs) 0.0.13 or newer (AUR: `noctalia-qs`). Upstream noctalia-qs is archived, and its last release (0.0.12) does not build with Qt 6.12.
- Qt 6.11 or newer

---

## About

Noctalia v4 is a desktop shell for Wayland, built on Quickshell.

**✨ Key Features:**
- 🪟 Native support for Niri, Hyprland, Sway, Scroll, Labwc and MangoWC
- 🎨 Extensive theming with predefined color schemes and automatic color generation from your wallpaper
- 🖼️ Wallpaper management with Wallhaven integration
- 🔔 Notification system with history and Do Not Disturb
- 🖥️ Multi-monitor support
- 🔒 Lock screen
- 🧩 Desktop widgets (clock, media player and more)
- 💡 OSD for volume and brightness
- 🔌 More than 100 plugins available
- 🪄 Setup wizard for first-time users
- ⚡ Built on Quickshell for performance

---

## Preview

https://github.com/user-attachments/assets/bf46f233-8d66-439a-a1ae-ab0446270f2d

<details>
<summary>Screenshots</summary>

![Dark 1](/Assets/Screenshots/noctalia-dark-1.png)
![Dark 2](/Assets/Screenshots/noctalia-dark-2.png)
![Dark 3](/Assets/Screenshots/noctalia-dark-3.png)

![Light 1](/Assets/Screenshots/noctalia-light-1.png)
![Light 2](/Assets/Screenshots/noctalia-light-2.png)
![Light 3](/Assets/Screenshots/noctalia-light-3.png)

</details>

---

## 🖥️ Wayland Compositors

Noctalia provides native support for **Niri**, **Hyprland**, **Sway**, **Scroll**, **Labwc** and **MangoWC**. Other Wayland compositors may work but could require additional configuration for compositor-specific features like workspaces and window management.

---

## Scope

Noctalia is a **desktop shell**, not a full desktop environment. It provides the visual layer that sits on top of your Wayland compositor (bars, panels, notifications, a dock, and widgets) but it intentionally stays within that boundary. Understanding this helps set the right expectations for feature requests.

### What Noctalia does

Noctalia focuses on the things a shell is responsible for: status bar, panels, application launcher, notifications, lock screen, idle management, OSD, theming, wallpapers, desktop widgets, dock, and multi-monitor support.

### What belongs in a plugin

If a feature is useful to some users but not essential to the core shell experience, it's a great candidate for a plugin. The v4 plugin system can add bar widgets, panels, launcher providers, desktop widgets, and more.

Some examples of features that are better suited as plugins:
- Compositor-specific extras (e.g., Steam overlay for Hyprland)
- Hardware-specific controls (e.g., laptop fan profiles, battery thresholds)
- Third-party service integrations (e.g., smart home controls, Tailscale)
- Niche productivity tools (e.g., Pomodoro timer, RSS reader, Docker manager)
- Alternative visualizations or widgets

### What falls outside our scope

Some features go beyond what a desktop shell can or should do. These are typically responsibilities of the compositor, a dedicated application, or the system itself:

- **File management**: use a file manager application
- **Display/login greeter**: this runs before the shell and is managed separately
- **Window management and overview**: workspace switching and window tiling are compositor responsibilities
- **Removable drive mounting**: handled by system services like udisks and desktop applications
- **Screen mirroring/casting**: managed by the compositor or dedicated tools

We appreciate feature suggestions, but if a request falls into this category, it's likely outside what Noctalia can provide. 

---

## 💜 Credits

Noctalia is made by [noctalia-dev](https://github.com/noctalia-dev) and its [**contributors**](https://github.com/noctalia-dev/noctalia/graphs/contributors). This fork only keeps the v4 code running; all credit for Noctalia itself goes to them.

---

## ☕ Donations

If you want to support Noctalia, donate to the upstream project:

<p>
  <a href="https://www.buymeacoffee.com/noctalia">
    <img src="https://img.shields.io/badge/Buy_Me_a_Coffee-A8AEFF?style=for-the-badge&logo=buymeacoffee&logoColor=FFFFFF&labelColor=0C0D11" alt="Buy Me a Coffee">
  </a>
  <a href="https://ko-fi.com/noctaliadev">
    <img src="https://img.shields.io/badge/Ko--fi-A8AEFF?style=for-the-badge&logo=kofi&logoColor=FFFFFF&labelColor=0C0D11" alt="Ko-fi">
  </a>
</p>

---

## 📄 License

MIT License - see [LICENSE](./LICENSE) for details.
