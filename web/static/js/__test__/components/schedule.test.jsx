import React from "react";
import renderer from "react-test-renderer";

import Schedule from "components/schedule";

describe("Schedule component", () => {
  it("renders correctly", () => {
    const props = {
      toggleAutopilot: jest.fn()
    };
    const tree = renderer.create(
      <Schedule {...props} />
    );

    expect(tree).toMatchSnapshot();
  });
});
