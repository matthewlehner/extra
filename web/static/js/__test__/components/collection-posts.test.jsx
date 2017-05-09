// @flow

import React from "react";
import renderer from "react-test-renderer";

import CollectionPosts from "components/collection-posts";

describe("PostList component", () => {
  it("renders a list of posts", () => {
    const props = {
      posts: [{
        id: "1",
        body: "hey buddy."
      }]
    };

    const tree = renderer.create(<CollectionPosts {...props} />);

    expect(tree).toMatchSnapshot();
  });
});
