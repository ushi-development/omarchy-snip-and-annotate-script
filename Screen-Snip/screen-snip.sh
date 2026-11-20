#!/usr/bin/env bash
# Select a screen region and annotate it in Satty before saving or copying.
set -euo pipefail

for dependency in grim slurp satty wl-copy; do
  if ! command -v "$dependency" >/dev/null 2>&1; then
    printf 'Required command not found: %s\n' "$dependency" >&2
    exit 1
  fi
done

# Escape cancels without taking a screenshot.
region=$(slurp) || exit 0
[[ -n "$region" ]] || exit 0

pictures_dir=$(xdg-user-dir PICTURES 2>/dev/null) || pictures_dir="$HOME/Pictures"
output_dir="${pictures_dir:-$HOME/Pictures}/Screenshots"
mkdir -p "$output_dir"
output_file="$output_dir/Screenshot-$(date +%Y-%m-%d_%H-%M-%S-%N).png"

# Keep the original in memory. Enter saves the annotated image and copies it;
# Escape closes the editor without saving. Ctrl+S saves without closing.
grim -g "$region" -t ppm - | satty \
  --filename - \
  --output-filename "$output_file" \
  --initial-tool highlight \
  --copy-command 'wl-copy --type image/png' \
  --save-after-copy \
  --actions-on-enter save-to-clipboard,exit \
  --actions-on-escape exit
