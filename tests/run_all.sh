#!/bin/bash
# tests/run_all.sh - GS tests of this repository (CI runs it on every pull request and push to the GS branches).
# Works on a copy of the tracked files, so the checkout stays clean. Needs Node.js 24 and pnpm (version from
# package.json `packageManager`) and the npm registry.
set -u; cd "$(dirname "$0")/.."; G=$PWD; rc=0; PNPM=${PNPM:-pnpm}
res(){ if [ "$2" = 0 ]; then echo "### PASS $1"; else echo "### FAIL $1"; rc=1; fi; }
W=$(mktemp -d); mkdir -p "$W/src"; git ls-files -z | (cd "$G" && xargs -0 cp --parents -t "$W/src")

python3 - "$W/src/package.json" <<'PY'
import json, sys
# Test only: the renamed GZA packages are not published under their GS names; resolve each to its upstream name
# at the same version (same code).
UP = {"gza-core": "zigbee-herdsman", "gza-core-libs": "zigbee-herdsman-converters", "gza-frontend": "zigbee2mqtt-frontend"}
p = sys.argv[1]; d = json.load(open(p))
for sec in ("dependencies", "devDependencies", "peerDependencies"):
    for k, v in list(d.get(sec, {}).items()):
        if k in UP and not v.startswith("npm:"):
            d[sec][k] = f"npm:{UP[k]}@{v}"
json.dump(d, open(p, "w"), indent=4)
PY

cd "$W/src"
ok_name=$(node -p "require('./package.json').name"); [ "$ok_name" = "gza-core-libs" ]; res "package name is gza-core-libs" $?
$PNPM install --no-frozen-lockfile > "$W/install.log" 2>&1; r=$?; [ $r = 0 ] || tail -20 "$W/install.log"; res "install" $r
$PNPM run build > "$W/build.log" 2>&1; r=$?; [ $r = 0 ] || tail -20 "$W/build.log"; res "build (tsc)" $r
$PNPM run test > "$W/test.log" 2>&1; r=$?; grep -E "Test Files|Tests  " "$W/test.log"; [ $r = 0 ] || grep -E "^ FAIL|Error" "$W/test.log" | head -20
res "gza-core-libs unit suite (test)" $r
[ $rc = 0 ] && echo "ALL PASS" || echo "SOME FAILED"; exit $rc
