#!/usr/bin/env bash
# check-untracked-packages.sh
# Reports explicitly-installed pacman packages not listed in any dd-<name> file
# in the current directory (or a directory passed as $1).

set -euo pipefail

SEARCH_DIR="${1:-.}"

# ── 1. Collect packages ──────────────────────────────────────────────────────
mapfile -t packages < <(
  sudo pacman -Qe \
    | awk '{print $1}'
)

if [[ ${#packages[@]} -eq 0 ]]; then
  echo "No explicitly-installed packages found." >&2
  exit 1
fi

# ── 2. Collect tracked-package files (regex: two digits, dash, lowercase word) ──
mapfile -t tracked_files < <(
  find "$SEARCH_DIR" -maxdepth 1 -type f \
    | grep -E '/[0-9]{2}-[a-z_]+$'
)

# ── 3. Build a single string of all tracked content for fast lookup ───────────
tracked_content=""
for f in "${tracked_files[@]}"; do
  tracked_content+=$'\n'"$(cat "$f")"
done
tracked_content+=$'\b'"$(cat yay_packages)"

# ── 4. Report packages not found in any tracked file ─────────────────────────
untracked=()
for pkg in "${packages[@]}"; do
  # Match the package name as a whole word so e.g. "git" doesn't match "git-lfs"
  if ! grep -qw "$pkg" <<< "$tracked_content"; then
	if [ "$pkg" = "yay" ] || \
		[ "$pkg" = "yay-debug" ] || \
		[ "$pkg" = "flatpak" ] ; then
		continue
	fi
    untracked+=("$pkg")
  fi
done

# ── 5. Output ─────────────────────────────────────────────────────────────────
if [[ ${#untracked[@]} -eq 0 ]]; then
  echo "All packages are tracked."
else
  echo "Packages NOT found in any tracked file (${#untracked[@]}):"
  printf '  %s\n' "${untracked[@]}"
fi
