import React from "react";
import renderer from "react-test-renderer";

import Tabs from "components/tabs";

const panels = [{
  label: "Monday",
  content: "hi bud"
}, {
  label: "Tuesday",
  content: "great day"
}];

describe("Tabs", () => {
  it("renders tabs", () => {
    const props = { panels };
    const tree = renderer.create(
      <Tabs {...props} />
    );

    expect(tree).toMatchSnapshot();
  });

  it("can specify active panel", () => {
    const props = { panels, activePanel: panels[1].label };
    const tree = renderer.create(
      <Tabs {...props} />
    );

    expect(tree).toMatchSnapshot();
  });
});
