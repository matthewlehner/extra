// @flow

import React from "react";
import renderer from "react-test-renderer";

import CheckboxCollection from "../checkbox-collection";

describe("CheckboxCollection component", () => {
  const options = [{ value: "0", label: "matthewpearse", provider: "twitter" }];
  const fieldName = "channels";
  const value = {};

  it("renders correctly", () => {
    const tree = renderer.create(
      <CheckboxCollection
        fieldName={fieldName}
        value={value}
        options={options}
        onChange={jest.fn()}
      />
    );

    expect(tree).toMatchSnapshot();
  });
});

