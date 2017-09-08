import React from "react";
import renderer from "react-test-renderer";

import TimeslotForm from "components/timeslot-form";

const recurrenceValues = [{ name: "MONDAY" }, { name: "EVERYDAY" }];

describe("TimeslotForm component", () => {
  it("renders a form", () => {
    const props = {
      recurrences: recurrenceValues,
      collections: [{ id: "1", name: "Cool bud" }, { id: "25", name: "Misc." }],
      onCancel: jest.fn(),
      onSubmit: jest.fn()
    };

    const tree = renderer.create(<TimeslotForm {...props} />);
    expect(tree).toMatchSnapshot();
  });
});
