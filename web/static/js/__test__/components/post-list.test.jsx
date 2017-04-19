// @flow

import React from "react";
import renderer from "react-test-renderer";

import PostList from "components/post-list";

describe("PostList component", () => {
  it("renders a list of posts", () => {
    const props = {
      posts: [{
        id: "1",
        body: "hey buddy."
      }]
    };

    const tree = renderer.create(<PostList {...props} />);

    expect(tree).toMatchSnapshot();
  });
});
