import React from "react";
import renderer from "react-test-renderer";
import { MemoryRouter } from "react-router-dom";

import Schedule from "components/schedule";

describe("Schedule component", () => {
  it("renders correctly", () => {
    const props = {
      toggleAutopilot: jest.fn(),
      schedule: {
        autopilot: true,
        timeslots: []
      }
    };
    const tree = renderer.create(
      <MemoryRouter>
        <Schedule {...props} />
      </MemoryRouter>
    );

    expect(tree).toMatchSnapshot();
  });
});
