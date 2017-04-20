import React from "react";
import renderer from "react-test-renderer";
import { MemoryRouter, Route } from "react-router-dom";

import NewPostContent from "components/new-post-content";

describe("NewPostContent component", () => {
  it("renders properly", () => {
    const tree = renderer.create(
      <MemoryRouter initialEntries={["/collections/1/new"]}>
        <Route
          path="/collections/:id/new"
          render={props => (
            <NewPostContent {...props} />
          )}
        />
      </MemoryRouter>
    );

    expect(tree).toMatchSnapshot();
  });
});
