import React from "react";
import renderer from "react-test-renderer";

import Tabs from "components/tabs";

describe("Tabs", () => {
  it("renders tabs", () => {
    const props = {
      tabContents: [{
        label: "Monday",
        content: "hi bud",
        selected: true
      }, {
        label: "Tuesday",
        content: "great day"
      }]
    };
    const tree = renderer.create(
      <Tabs {...props} />
    );

    expect(tree).toMatchSnapshot();
  });
});
