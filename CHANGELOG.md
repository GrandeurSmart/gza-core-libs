# Changelog

GS entries only. Base release notes: https://github.com/Koenkk/zigbee-herdsman-converters/releases (this branch is based on release 26.125.0).

## gza-core-libs 26.125.0 for GZA 2.14.3 (candidate, branch gza-2.14.3) — 2026-11-07

- Base 26.125.0 (commit `c18c32d94c77`).
- Package named `gza-core-libs`, with GZA names for the other GZA packages and repository links to the GrandeurSmart
  repositories. No other code changes.
- 4,620 device definitions from 477 brands (5,828 product models from 616 brands counting rebranded
  variants); includes `_TZE284_rccxox8p`.
- Repository links fixed: `package.json` `repository`, `bugs` and `homepage`, and links in source comments
  and messages, point at the real GrandeurSmart repositories (the earlier rename order produced links to
  repositories that do not exist). Links only; no code logic changed.
- LICENSE and copyright notices unchanged; `package.json` keeps the original author and contributors, with
  Mainlogix Technology recorded as `gzaMaintainer`.
- Shipped inside the GZA overlay `libs-2.14.3.tgz` (sha256 `c9a8ded13afe…`), built by
  grandeursmart-zigbee-automation `gza/build_libs.py`.
- Status: candidate; merged only after the OS image first-boot test passes on the lab gateway.
