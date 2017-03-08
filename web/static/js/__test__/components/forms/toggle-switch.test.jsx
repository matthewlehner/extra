import React from "react";
import renderer from "react-test-renderer";

import ToggleSwitch from "components/forms/toggle-switch";

const onChange = () => {};

describe("ToggleSwitch component", () => {
  it("renders checked state correctly", () => {
    const tree = renderer.create(
      <ToggleSwitch checked onChange={onChange} />
    );

    expect(tree).toMatchSnapshot();
  });

  it("renders unchecked state correctly", () => {
    const tree = renderer.create(
      <ToggleSwitch checked={false} onChange={onChange} />
    );

    expect(tree).toMatchSnapshot();
  });
});
