// @flow

import React from "react";
import renderer from "react-test-renderer";

import Textarea from "../textarea";

describe("Textarea component", () => {
  it("renders properly", () => {
    const tree = renderer.create(<Textarea />);

    expect(tree).toMatchSnapshot();
  });
});
