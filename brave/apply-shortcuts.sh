#!/usr/bin/env bash
# Apply my custom Brave keyboard shortcuts (brave.accelerators) from accelerators.json.
# Brave Sync does not carry these, so run this once after Brave's first launch.
#
# Usage: close Brave completely, then run:  ./apply-shortcuts.sh
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
src="$here/accelerators.json"
prefs="${BRAVE_PREFS:-$HOME/.config/BraveSoftware/Brave-Browser/Default/Preferences}"

if pgrep -x brave >/dev/null || pgrep -f 'brave-browser' >/dev/null; then
  echo "Brave is running. Close it completely (check the tray too) and run this again." >&2
  exit 1
fi
[[ -f "$src" ]]   || { echo "Missing $src" >&2; exit 1; }
[[ -f "$prefs" ]] || { echo "No Brave profile at $prefs. Open Brave once first." >&2; exit 1; }

backup="$prefs.bak-$(date +%d-%b-%Y-%H%M%S)"
cp -- "$prefs" "$backup"
echo "Backed up Preferences to: $backup"

python3 -I - "$prefs" "$src" <<'PY'
import json, sys
prefs_path, src_path = sys.argv[1], sys.argv[2]
with open(prefs_path) as f:
    prefs = json.load(f)
with open(src_path) as f:
    acc = json.load(f)["brave"]["accelerators"]
prefs.setdefault("brave", {})["accelerators"] = acc
with open(prefs_path, "w") as f:
    json.dump(prefs, f, separators=(",", ":"))
print(f"Applied {len(acc)} shortcut entries. Start Brave to use them.")
PY
