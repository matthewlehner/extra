// @flow

import React from "react";
import renderer from "react-test-renderer";

import Post from "components/post";

describe("Post component", () => {
  it("renders correctly", () => {
    const tree = renderer.create(
      <Post id="1">
        I am the child.
      </Post>
    );

    expect(tree).toMatchSnapshot();
  });
});
