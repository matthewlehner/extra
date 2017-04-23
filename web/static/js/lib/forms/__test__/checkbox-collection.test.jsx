// @flow

import React from "react";
import renderer from "react-test-renderer";

import CheckboxCollection from "../checkbox-collection";

describe("CheckboxCollection component", () => {
  const options = [{ value: "0", label: "matthewpearse", provider: "twitter" }];

  it("renders correctly", () => {
    const tree = renderer.create(
      <CheckboxCollection options={options} />
    );

    expect(tree).toMatchSnapshot();
  });
});

