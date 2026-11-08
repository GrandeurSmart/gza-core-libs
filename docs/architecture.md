            # Architecture

            `gza-core-libs` is one of the four parts of GZA, the GS Zigbee service:

            | Part | Repository | Base version |
            |---|---|---|
            | GZA service | grandeursmart-zigbee-automation | 2.14.3 |
            | GZA core — Zigbee radio layer | gza-core | 11.2.0 |
            | GZA device library | gza-core-libs | 26.125.0 |
            | GZA frontend | gza-frontend | 0.9.21 |

            On the gateway the package is loaded from the GZA overlay (`node_modules/gza-core-libs`) inside the GZA container.
            - Matches each joining device to its definition (model, brand, firmware identifiers).
- Turns Zigbee messages into device state and GS commands into Zigbee messages.
- Describes each device's features, which GZA announces to GS core as entities.

**Supported devices.** The GZA device library (`gza-core-libs`, base 26.125.0) has **4,620 device definitions from
477 brands**; counting the rebranded variants listed under those definitions, it covers **5,828 product models from
616 brands** (brands are the distinct vendor names in the library). GS device files that are not in this library
(GS_1, GS_OWON, GS_TS0001) live in GSLocalBackend `add-ones/gza/converters-2/` and grandeursmart-zigbee-automation
`gza/converters/`, not here.
