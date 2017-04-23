// @flow

import React from "react";
import renderer from "react-test-renderer";

import Textarea from "../textarea";

const fieldName = "a-textarea";
const onChange = jest.fn();
const value = "content";

describe("Textarea component", () => {
  it("renders properly", () => {
    const tree = renderer.create(
      <Textarea fieldName={fieldName} onChange={onChange} value={value} />
    );

    expect(tree).toMatchSnapshot();
  });
});
