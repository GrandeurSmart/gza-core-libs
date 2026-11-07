# GZA device library — supported device definitions for GZA

The GZA device library holds the definitions of the Zigbee devices GZA supports. It is one of the four parts of GZA, the GrandeurSmart (GS) Zigbee service; see
grandeursmart-zigbee-automation for the whole service.

This branch, `gza-2.14.3`, is the **GZA 2.14.3 candidate** (base 26.125.0, commit `c18c32d94c77`). The default
branch `gs` holds the version used by GZA 1.35.1.

Maintained by Mainlogix Technology for GrandeurSmart. Report issues in this repository's GitHub Issues; for GZA as a whole, use grandeursmart-zigbee-automation.

## What it does in GZA
- Matches each joining device to its definition (model, brand, firmware identifiers).
- Turns Zigbee messages into device state and GS commands into Zigbee messages.
- Describes each device's features, which GZA announces to GS core as entities.

## Supported devices
The GZA device library (`gza-core-libs`, base 26.125.0) has **4,620 device definitions from 477 brands**; counting the rebranded variants listed under those definitions, it covers **5,828 product models from 616 brands** (brands are the distinct vendor names in the library).

GS device files that are not in this library (GS_1, GS_OWON, GS_TS0001) live in GSLocalBackend
`add-ones/gza/converters-2/` and grandeursmart-zigbee-automation `gza/converters/`, not here.


## Names
The package is `gza-core-libs`. Lockfiles still list `zigbee-herdsman-converters` (compatibility identifier, unchanged by design). The GS changes on this branch
are names and repository links only; LICENSE and the copyright notices in the code are unchanged.

## How GS builds and ships it
The gateway does not build from this branch. It runs a pinned base image with the GZA overlay
(`libs-2.14.3.tgz`) mounted over it, and `gza-core-libs` is one of the packages in that overlay. The overlay is built
byte for byte by grandeursmart-zigbee-automation `gza/build_libs.py`:

```
git clone --branch gza-2.14.3 https://github.com/GrandeurSmart/grandeursmart-zigbee-automation.git
python3 grandeursmart-zigbee-automation/gza/build_libs.py /tmp/gza-build    # Python 3.9+, Node.js 24 on PATH
```

- Pinned base image: `koenkk/zigbee2mqtt@sha256:f09106ecf103a8ab33cf96cae9d7eee56f1da0000682fa754cab37f02b530910` (linux/arm64).
- Expected result: sha256 `22665cd9a42e6d5a9f97d0c4deb5423ca2b60f8484bd4c81ccdf5e0b3a65c91a` (the script prints MATCH).

This branch is the matching source, for review and provenance.

## How it runs, rollback and new base releases
GSLocalBackend's `run.sh` selects the GZA version from the image tag in `env.sh`; GSLocalBackend
`tools/gza/gza_image_test.sh` captures data before an update and rolls back to 1.35.1. To move to a new base
release, follow "Moving to a new base release" in the grandeursmart-zigbee-automation README: this repository
gets a branch from `gs` with the new base sources and the same GZA names.

## Status
**Candidate.** Not merged until the OS image first-boot test passes on the lab gateway.

## Credits and licence
The GZA device library is derived from the open-source zigbee-herdsman-converters project (part of the zigbee2mqtt project) and its contributors. Licence: MIT, see
`LICENSE`. Copyright notices in the code are unchanged.
