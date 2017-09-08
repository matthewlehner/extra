// @flow
import React from "react";
import renderer from "react-test-renderer";
import Label from "../label";

describe("Label component", () => {
  it("renders correctly", () => {
    const tree = renderer.create(
      <Label htmlFor="something" content="label">
        The label.
      </Label>
    );

    expect(tree).toMatchSnapshot();
  });
});
