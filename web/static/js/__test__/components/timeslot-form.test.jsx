import React from "react";
import renderer from "react-test-renderer";

import TimeslotForm from "components/timeslot-form";

const recurrenceValues = [{ name: "MONDAY" }, { name: "EVERYDAY" }];

describe("TimeslotForm component", () => {
  it("renders a form", () => {
    const onChange = jest.fn();
    const props = {
      time: { value: "01:30", onChange },
      recurrence: { value: "", onChange, options: recurrenceValues },
      collection: {
        value: "",
        options: [{ id: "1", name: "Cool bud" }, { id: "25", name: "Misc." }],
        onChange
      },
      onCancel: jest.fn(),
      onSubmit: jest.fn()
    };

    const tree = renderer.create(<TimeslotForm {...props} />);
    expect(tree).toMatchSnapshot();
  });
});
