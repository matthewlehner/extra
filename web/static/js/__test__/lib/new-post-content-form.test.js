// @flow

import postContentForm, {
  collectionSelectOptions,
  channelMultiSelectOptions
} from "lib/new-post-content-form";

const collections = [
  { name: "organization", id: "10" },
  { id: "200", name: "something else." }
];

const channels = [{ id: "1", name: "trumpets", provider: "twitter" }];

describe("postContentForm", () => {
  const form = postContentForm(collections, channels);

  it("has an input property", () => {
    expect(form).toHaveProperty("input", expect.objectContaining({}));
  });

  it("has collection properties", () => {
    expect(form).toHaveProperty("inputs.collection.label", "Collection");
    expect(form).toHaveProperty(
      "inputs.collection.options",
      collectionSelectOptions(collections)
    );
  });

  it("has content properties", () => {
    expect(form).toHaveProperty("inputs.content.label", "Content");
  });

  it("has channel properties", () => {
    expect(form).toHaveProperty("inputs.channels.label", "Channels");
    expect(form).toHaveProperty(
      "inputs.channels.options",
      channelMultiSelectOptions(channels)
    );
  });
});

describe("collectionSelectOptions", () => {
  it("returns an array of options", () => {
    const expected = [
      { value: "10", label: "organization" },
      { value: "200", label: "something else." }
    ];

    expect(
      collectionSelectOptions(collections)
    ).toEqual(expected);
  });
});

describe("channelMultiSelectOptions", () => {
  it("returns an array of options", () => {
    const expected = [{ value: "1", label: "trumpets", provider: "twitter" }];

    expect(
      channelMultiSelectOptions(channels)
    ).toEqual(expected);
  });
});
