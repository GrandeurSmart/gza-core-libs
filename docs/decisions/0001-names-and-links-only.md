# ADR-0001: Names and links only; the overlay is built from the pinned image

| Field | Value |
|---|---|
| Decision ID | ADR-0001 |
| Status | Accepted |
| Owner | RADIOS |
| Date | 2026-11-07 |

## Context
GZA ships to gateways as an overlay on a pinned upstream image, built byte for byte by
grandeursmart-zigbee-automation `gza/build_libs.py`.

## Selected proposal
This branch carries the upstream sources with the GZA names (`gza-core-libs`) and GS repository links only.
`zigbee-herdsman-converters` stays as a compatibility identifier where lockfiles and upstream tooling need it. LICENSE and
copyright notices are unchanged. Code changes for GZA go through the overlay build and its tests.

## Approval history
| Date | Who (role) | Decision |
|---|---|---|
| 2026-11-07 | Owner | GZA 2.14.3 names, docs and links approved |
