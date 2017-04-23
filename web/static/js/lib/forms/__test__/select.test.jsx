// @flow

import React from "react";
import renderer from "react-test-renderer";

import Select from "../select";

describe("Select component", () => {
  const options = [{ value: "1", label: "Inspirational Posts" }];
  const fieldName = "a-select-field";
  const onChange = jest.fn();

  it("renders correctly", () => {
    const tree = renderer.create(
      <Select options={options} fieldName={fieldName} onChange={onChange} />
    );

    expect(tree).toMatchSnapshot();
  });
});
