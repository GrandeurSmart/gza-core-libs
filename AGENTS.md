# AGENTS.md — GrandeurSmart rules

Rules for anyone, people or automated agents, changing this repository. It is part of GZA, the GrandeurSmart
(GS) Zigbee service, maintained by Mainlogix Technology for GrandeurSmart. These rules apply until a shared GS
rules file replaces them.

## Wording
- Docs describe GrandeurSmart products. Say "GS" or "GS core" in prose.
- Compatibility identifiers stay unchanged and appear in code formatting, marked as compatibility identifiers:
  MQTT base topic `zigbee2mqtt`, discovery prefix `homeassistant`, the `homeassistant` config key,
  `switch.zigbee2mqtt_bridge_permit_join`.
- Do not rename code identifiers beyond the GZA naming rules in grandeursmart-zigbee-automation
  `gza/gza_rebase.py`.

## Licence and credits
- Keep LICENSE, any NOTICE, third-party licence files and copyright headers unchanged.
- Keep the original `author` and `contributors` in `package.json`.

## Data and secrets
- No secrets, keys, DSKs, passwords or tokens in any file, commit, log or pull request.
- No gateway or lab data: device addresses, IP addresses, network fingerprints, database copies or expected-ID
  lists.
- No personal names in commits, docs or code.
- Run a secret scan on every added or changed file before each push.

## Branches
- Work on branches. No force push, no change to the default branch `gs`, no merges and no tags without owner
  approval.
- Pull requests stay draft until the OS image first-boot test passes on the lab gateway.
- GitHub Actions stay disabled.

## Build and test
- This branch is source for review; the shipped overlay is built by grandeursmart-zigbee-automation
  `gza/build_libs.py`. Build and tests are described in that repository's README.

## Security
See `SECURITY.md`.
