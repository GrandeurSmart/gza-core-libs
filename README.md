# About this fork — gza-core-libs (GZA 2.14.3 candidate)

This repository is GrandeurSmart's fork of **[zigbee-herdsman-converters](https://github.com/Koenkk/zigbee-herdsman-converters)**, used by GZA,
GrandeurSmart's Zigbee service (based on zigbee2mqtt). This branch is upstream **zigbee-herdsman-converters 26.125.0**
(tag at commit `c18c32d94c77`), unchanged except for the GS changes below. All credit for the code goes to
the upstream authors and contributors; the licence is upstream's **MIT** (see `LICENSE`, unchanged), and
`package.json` keeps the upstream author and contributors (GrandeurSmart is recorded as `gzaMaintainer`).

### What GS changes
Names and branding only, so the packages can sit side by side with upstream ones:
`zigbee-herdsman` → `gza-core`, `zigbee-herdsman-converters` → `gza-core-libs`, `zigbee2mqtt-frontend` →
`gza-frontend`, the matching `zigbee_herdsman*` keys, and repository links pointing at the GrandeurSmart forks.
The branding commit left LICENSE, README, CHANGELOG, docs and lockfiles untouched; this section (and, in
grandeursmart-zigbee-automation, a GZA section at the top of CHANGELOG.md) was added afterwards. No device logic is changed here: GS device
converters (GS_1, GS_OWON, GS_TS0001) live in GSLocalBackend (`add-ones/gza/converters-2/`) and in
grandeursmart-zigbee-automation `gza/converters/`.

### How to build reproducibly
The overlay GZA ships (`libs-2.14.3.tgz`) is built by the `gza/` folder of
[grandeursmart-zigbee-automation](https://github.com/GrandeurSmart/grandeursmart-zigbee-automation/tree/gza-2.14.3/gza),
branch `gza-2.14.3`, from upstream's published image pinned by digest:

```
git clone --branch gza-2.14.3 https://github.com/GrandeurSmart/grandeursmart-zigbee-automation.git
python3 grandeursmart-zigbee-automation/gza/build_libs.py /tmp/gza-build   # needs Python 3.9+ and Node.js 24 on PATH
```
- Pinned image: `koenkk/zigbee2mqtt@sha256:f09106ecf103a8ab33cf96cae9d7eee56f1da0000682fa754cab37f02b530910` (linux/arm64)
- Expected sha256: `22665cd9a42e6d5a9f97d0c4deb5423ca2b60f8484bd4c81ccdf5e0b3a65c91a` (the script prints MATCH)

The overlay is taken from upstream's compiled image, not compiled from this source tree, so it matches what
upstream ships. This branch is the matching source, for review and provenance.

### How GS uses it
On the gateway GZA runs as the stock upstream zigbee2mqtt image with the GZA overlay mounted over it
(`dist/`, `node_modules/gza-core`, `gza-core-libs`, `gza-frontend`), launched by GSLocalBackend's `run.sh`.
The GZA image tag in `env.sh` selects the layout: a 1.x tag keeps the old 1.35.1 layout unchanged; tag
`2.14.3` unpacks `add-ones/gza/libs/libs-2.14.3.tgz` and loads the GS device converters from
`data/external_converters`. Rollback is the env.sh tag back to 1.35.1 plus the data captured before the
switch (`tools/gza/gza_rollback.sh`, `tools/gza/gza_image_test.sh rollback` in GSLocalBackend).

### Moving to a new upstream release
1. Check the new zigbee2mqtt release and the versions of zigbee-herdsman, zigbee-herdsman-converters and the
   frontend inside its image.
2. In grandeursmart-zigbee-automation `gza/build_libs.py`, set the new image digest; build; record the new
   sha256 in `gza/EXPECTED_SHA256`.
3. In each fork, make a branch from `gs` with an "init with <upstream version>" commit (the upstream tag's
   tracked files) and a branding commit (the same renames as `gza/gza_rebase.py`).
4. Rerun: `gza/tests` (t_conv, t_load, t_brand) on a stock+overlay tree; the GZA boot test; GSLocalBackend
   run.sh tests; `gza_image_test.sh` (capture → verify → rollback); the Home Assistant discovery comparison
   with `gza/tools`. Check whether upstream now covers any GS converter.
5. Draft PR; merge only after the OS image first-boot test passes on the lab unit.

### Status
**Candidate.** Branch `gza-2.14.3` is not merged and will not be until the OS image first-boot test passes on
the lab unit. The default branch `gs` still holds the 1.35.1-based version GZA ships today.

---

*The upstream README follows unchanged.*

[![NPM](https://nodei.co/npm/zigbee-herdsman-converters.png)](https://www.npmjs.com/package/zigbee-herdsman-converters)

# zigbee-herdsman-converters

Collection of device converters to be used with zigbee-herdsman.

## Contributing

See [Zigbee2MQTT how to support new devices](https://www.zigbee2mqtt.io/advanced/support-new-devices/01_support_new_devices.html).

### Creating a pull request

#### Github codespaces

You can use Github codespaces to create pull requests with a fully setup editor, right from your web browser:
- https://docs.github.com/en/codespaces/developing-in-a-codespace/creating-a-codespace-for-a-repository
- https://docs.github.com/en/codespaces/developing-in-a-codespace/using-github-codespaces-for-pull-requests

#### Locally

Install the prerequisites:

```sh
npm install -g pnpm
pnpm install --frozen-lockfile
```

#### Submitting your pull request

Before you submit a pull request, you should run the following commands to ensure your changes will pass the tests:

```sh
pnpm run check --fix
pnpm run build
pnpm test
```

If any of those commands finish with an error your PR won't pass the tests and will likely be rejected.

## Breaking changes

25.0.0
- Changed the `onEvent` api, see https://github.com/Koenkk/zigbee-herdsman-converters/pull/9650 for more info.
- A `device` argument has been added to `postProcessConvertedFromZigbeeMessage` (https://github.com/Koenkk/zigbee-herdsman-converters/pull/9693)
- `rawData` now needs to be provided to `Fz.Message.meta` (https://github.com/Koenkk/zigbee-herdsman-converters/pull/9775)

24.0.0
- It's not longer possible to call `definition.exposes(undefined, undefined)`, use `definition.exposes({isDummyDevice: true}, {})` instead (#9601)

23.0.0
- A `Publish` now has to be passed to toZigbee converters (#8875)

22.0.0
- `addDefinition` has been renamed to `addExternalDefinition`
- An import of `zigbee-herdsman-converters` does not expose all `definitions` anymore. Use this instead:
```js
(await import("zigbee-herdsman-converters/devices/index")).default.forEach((baseDefinition) => {
    const d = zhc.prepareDefinition(baseDefinition);
});
```

21.0.0
- Various breaking changes, see [CHANGELOG.md](https://github.com/Koenkk/zigbee-herdsman-converters/blob/v21.0.0/CHANGELOG.md#-breaking-changes).

20.0.0
- A toZigbee converter is now allowed to not define any `key`, in this case the converter should be used for any key.

19.0.0
- Legacy extend was removed

18.0.0
- After converting a message with a fromZigbee converter, `postProcessConvertedFromZigbeeMessage` should be called now (for applying calibration/precision)

17.0.0
- Various methods in `index.ts` are now async and return a `Promise`

15.0.0
- OTA `isUpdateAvailable` now returns an object instead of a boolean (e.g. `{available: true, currentFileVersion: 120, otaFileVersion: 125}`)
- OTA `updateToLatest` now returns a number (`fileVersion` of the new OTA) instead of a void
