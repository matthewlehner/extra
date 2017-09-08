// @flow

import React from "react";
import renderer from "react-test-renderer";
import Field from "../field";

describe("Field component", () => {
  it("renders correctly", () => {
    const tree = renderer.create(
      <Field label="Channel">
        Children are here.
      </Field>
    );

    expect(tree).toMatchSnapshot();
  });
});
