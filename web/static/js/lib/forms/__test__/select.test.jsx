// @flow

import React from "react";
import renderer from "react-test-renderer";

import Select from "../select";

describe("Select component", () => {
  const options = [{ value: "1", label: "Inspirational Posts" }];

  it("renders correctly", () => {
    const tree = renderer.create(
      <Select options={options} />
    );

    expect(tree).toMatchSnapshot();
  });
});
