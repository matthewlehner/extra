// @flow
import postContentForm, {
  updateInput,
  channelMultiSelectOptions
} from "lib/new-post-content-form";

const channels = [{ id: "1", name: "trumpets", provider: "twitter" }];

describe("postContentForm", () => {
  const form = postContentForm(channels);

  it("has an input property", () => {
    expect(form).toHaveProperty("input", expect.objectContaining({}));
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

describe("channelMultiSelectOptions", () => {
  it("returns an array of options", () => {
    const expected = [{ id: "1", name: "trumpets", provider: "twitter" }];

    expect(channelMultiSelectOptions(channels)).toEqual(expected);
  });
});

describe("updateInput", () => {
  it("updates input values", () => {
    const expectedValue = "some new content";
    const originalForm = postContentForm(channels);
    const newForm = updateInput("content", expectedValue, originalForm);

    expect(newForm).toHaveProperty("inputs.content.value", expectedValue);
  });
});
