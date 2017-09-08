import React from "react";
import renderer from "react-test-renderer";
import { MemoryRouter } from "react-router-dom";

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
    const props = { panels, name: "schedule" };
    const tree = renderer.create(
      <MemoryRouter>
        <Tabs {...props} />
      </MemoryRouter>
    );

    expect(tree).toMatchSnapshot();
  });

  it("can specify active panel", () => {
    const props = { panels, name: "schedule" };
    const tree = renderer.create(
      <MemoryRouter
        initialEntries={["?schedule=tuesday"]}
        initialIndex={0}
      >
        <Tabs {...props} />
      </MemoryRouter>
    );

    expect(tree).toMatchSnapshot();
  });
});
