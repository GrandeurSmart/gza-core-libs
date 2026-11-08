import {beforeEach, vi} from "vitest";
import {Adapter} from "gza-core/dist/adapter/adapter";
import {Database} from "gza-core/dist/controller/database";
import {Entity} from "gza-core/dist/controller/model";

vi.mock("gza-core/dist/adapter/adapter", () => ({
    Adapter: {
        create: () => ({}),
    },
}));

vi.mock("gza-core/dist/controller/database", () => ({
    Database: {
        open: () => ({
            getEntriesIterator: () => [] as unknown[],
            insert: vi.fn(),
            update: vi.fn(),
            remove: vi.fn(),
            has: vi.fn(() => false),
            newID: () => 1,
            write: vi.fn(),
            clear: vi.fn(),
        }),
    },
}));

beforeEach(async () => {
    const db = Database.open("noop");
    const adapter = await Adapter.create(
        {
            panID: 1,
            channelList: [11],
        },
        {},
        "noop",
        {
            disableLED: false,
        },
    );

    Entity.injectDatabase(db);
    Entity.injectAdapter(adapter);
});
