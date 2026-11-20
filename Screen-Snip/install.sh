#!/usr/bin/env bash
# Run on an Omarchy PC: bash install.sh
set -euo pipefail

app_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

for file in screen-snip.sh screen-snip.desktop; do
  if [[ ! -f "$app_dir/$file" ]]; then
    printf 'Missing app file: %s\n' "$app_dir/$file" >&2
    exit 1
  fi
done

if ! command -v omarchy >/dev/null 2>&1; then
  printf 'This installer requires Omarchy.\n' >&2
  exit 1
fi

if (( EUID == 0 )); then
  printf 'Run this installer as your normal desktop user, without sudo.\n' >&2
  exit 1
fi

omarchy pkg add grim slurp satty wl-clipboard

bin_dir="$HOME/.local/bin"
applications_dir="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
mkdir -p "$bin_dir" "$applications_dir"
install -m 755 "$app_dir/screen-snip.sh" "$bin_dir/screen-snip"

# Quote and escape the executable path for desktop-entry Exec syntax.
executable="$bin_dir/screen-snip"
executable=${executable//\\/\\\\}
executable=${executable//\"/\\\"}
executable=${executable//\`/\\\`}
executable=${executable//\$/\\\$}
executable=${executable//%/%%}
while IFS= read -r line || [[ -n "$line" ]]; do
  if [[ "$line" == Exec=* ]]; then
    printf 'Exec="%s"\n' "$executable"
  else
    printf '%s\n' "$line"
  fi
done < "$app_dir/screen-snip.desktop" > "$applications_dir/screen-snip.desktop"
chmod 644 "$applications_dir/screen-snip.desktop"

if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$applications_dir" || true
fi

printf '\nInstalled! Search for Screen Snip in your app launcher.\n'
printf 'Select an area, annotate it, then press Enter to save and copy.\n'
