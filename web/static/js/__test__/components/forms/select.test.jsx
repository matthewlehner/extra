import React from "react";
import renderer from "react-test-renderer";

import Select from "components/forms/select";

describe("Select component", () => {
  it("renders a select element", () => {
    const props = {
      value: "1",
      onChange: jest.fn()
    };

    const tree = renderer.create(
      <Select {...props}>
        <option value="1">Hi</option>
        <option value="2">Ho</option>
      </Select>
    );

    expect(tree).toMatchSnapshot();
  });
});
