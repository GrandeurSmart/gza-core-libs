# Testing

`bash tests/run_all.sh` runs on a copy of the tracked files: install (its `gza-core` dependency resolved to the same version under its upstream name, test only), build, then the upstream vitest suite. CI runs it on every pull request
together with `bash tools/check_standard.sh`.

| Test | Kind | What it establishes | What it cannot establish |
|---|---|---|---|
| upstream unit suite on the GS-branded source | unit | the renamed package still behaves as upstream | the gateway, the radio, the overlay build |

The overlay that reaches gateways is tested in grandeursmart-zigbee-automation (byte-for-byte build, unit
suite with the GS packages, GS device files) and by the GSLocalBackend first-boot test (hardware).
Evidence level: locally reproduced.
