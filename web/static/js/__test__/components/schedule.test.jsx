import React from "react";
import renderer from "react-test-renderer";
import { MemoryRouter } from "react-router";

import Schedule from "components/schedule";

describe("Schedule component", () => {
  it("renders correctly", () => {
    const props = {
      toggleAutopilot: jest.fn()
    };
    const tree = renderer.create(
      <MemoryRouter>
        <Schedule {...props} />
      </MemoryRouter>
    );

    expect(tree).toMatchSnapshot();
  });
});
