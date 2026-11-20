# omarchy-snip-and-annotate-script
Screen Snip and Annotate script installer for Omarchy using grim, slurp and satty. - Installs as an app to menu

# Screen Snip

A small Bash screenshot app for Omarchy. Select part of your screen, highlight or annotate it in Satty, then save the result and copy it to your clipboard.

Screen Snip connects existing tools into a single app-launcher entry: Slurp selects the area, Grim captures it, and Satty provides the annotation editor.

## Features

- Drag to capture a selected area of the screen.
- Open the capture in Satty with the highlighting tool selected.
- Add arrows, text, shapes, and other annotations using Satty's toolbar.
- Save screenshots as PNG files with unique timestamped names.
- Copy the finished image to the clipboard for pasting into other apps.

## Requirements

The installer is intended for Omarchy PCs running a Wayland desktop that supports Grim and Slurp, such as Omarchy's Hyprland session.

It installs these packages through Omarchy:

| Package | Purpose |
| --- | --- |
| `grim` | Capture the selected screen area |
| `slurp` | Select an area with the mouse |
| `satty` | Edit and annotate the screenshot |
| `wl-clipboard` | Copy the finished image using `wl-copy` |

Bash is required. The script uses `xdg-user-dir` when available to locate your Pictures folder, otherwise it uses `~/Pictures`.

## Installation

1. Download this repository as a ZIP and extract it, or clone it with Git.
2. Open a terminal in the project folder.
3. Run:

   ```bash
   bash install.sh
   ```

Run the installer as your normal desktop user, without `sudo`. The package installer may request authentication to install dependencies.

The installer copies the script to `~/.local/bin/screen-snip` and adds a **Screen Snip** entry to your application launcher. It adjusts the launcher path for your user account automatically.

## Usage

1. Search for **Screen Snip** in your app launcher and open it.
2. Click and drag to select the area you want to capture.
3. Mark up the screenshot in Satty using the toolbar.
4. Press **Enter** to save the image, copy it to the clipboard, and close the editor.

You can also launch it from a terminal:

```bash
~/.local/bin/screen-snip
```

### Controls

| Action | Control |
| --- | --- |
| Cancel area selection | **Esc** in the selection overlay |
| Save, copy, and close | **Enter** in Satty |
| Save and continue editing | **Ctrl+S** in Satty |
| Close without saving further changes | **Esc** in Satty |

Closing the editor does not remove a screenshot you have already saved with **Ctrl+S**. When editing a text annotation, finish the text entry before using Enter to complete the screenshot.

### Saved screenshots

Images are saved in the `Screenshots` subfolder of your configured Pictures directory, usually:

```text
~/Pictures/Screenshots/
```

Example filename:

```text
Screenshot-2026-11-20_14-30-00-123456789.png
```

The initial capture is passed directly to Satty. A file is only created when you save or copy through the configured editor actions.

## Updating

Download or pull the updated project files, then run `bash install.sh` again. This replaces the installed script and launcher with the current versions.

## Uninstalling

Remove the installed script and app-launcher entry:

```bash
rm -f "$HOME/.local/bin/screen-snip"
rm -f "${XDG_DATA_HOME:-$HOME/.local/share}/applications/screen-snip.desktop"
```

Your saved screenshots and installed dependencies are kept.

## Project files

| File | Purpose |
| --- | --- |
| `screen-snip.sh` | Capture and annotation workflow |
| `screen-snip.desktop` | Application launcher template |
| `install.sh` | Dependency installation and user setup |

## Troubleshooting

- **The app does not open:** run `~/.local/bin/screen-snip` in a terminal to see any error messages.
- **A required command is missing:** rerun `bash install.sh` to install the dependencies.
- **The launcher is missing:** close and reopen your application launcher after installation.
- **Capture fails:** run the app inside your normal Omarchy Wayland desktop session.

## Credits

Screen Snip is a Bash wrapper around Grim, Slurp, Satty, and wl-clipboard. The capture, selection, annotation, and clipboard functionality is provided by those projects.
