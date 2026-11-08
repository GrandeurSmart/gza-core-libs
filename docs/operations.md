# Operations

This repository is not deployed on its own: its package reaches the gateway inside the GZA overlay
(`libs-2.14.3.tgz`), built by grandeursmart-zigbee-automation `gza/build_libs.py`. Operational runbooks for
GZA (start, first-boot test, rollback to 1.35.1) are in grandeursmart-zigbee-automation `docs/operations.md`
and GSLocalBackend `tools/gza/gza_image_test.sh`.

## Runbook: a behaviour of this package looks wrong on a gateway
1. Safe diagnosis: GZA log on the gateway; the overlay hash in use (must be the pinned one).
2. Evidence (redacted, no device addresses): GZA version, overlay hash, the log lines.
3. Decision: reproduce with this repository's unit suite (`bash tests/run_all.sh`) or a test added to it.
4. Recovery: GZA rollback to 1.35.1 (GSLocalBackend `gza_image_test.sh rollback`).
5. Escalation: RADIOS (owner of GZA).
