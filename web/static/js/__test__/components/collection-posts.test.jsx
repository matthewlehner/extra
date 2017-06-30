// @flow
import React from "react";
import renderer from "react-test-renderer";
import { MemoryRouter } from "react-router-dom";

import CollectionPosts from "components/collection-posts";

describe("PostList component", () => {
  it("renders a list of posts", () => {
    const props = {
      posts: [
        {
          id: "1",
          body: "hey buddy.",
          channels: []
        }
      ]
    };

    const tree = renderer.create(
      <MemoryRouter>
        <CollectionPosts {...props} />
      </MemoryRouter>
    );

    expect(tree).toMatchSnapshot();
  });
});
