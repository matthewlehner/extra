import React from "react";
import renderer from "react-test-renderer";
import { MemoryRouter, Route } from "react-router-dom";

import NewPostContent from "components/new-post-content";

const props = {
  data: {
    loading: false,
    error: false,
    collection: { id: "45", name: "howdy!" },
    channels: [{ id: "10", name: "matthewpearse", provider: "twitter" }]
  }
};

describe("NewPostContent component", () => {
  it("renders properly", () => {
    const tree = renderer.create(
      <MemoryRouter initialEntries={["/collections/1/new"]}>
        <Route
          path="/collections/:id/new"
          render={routerProps => <NewPostContent {...routerProps} {...props} />}
        />
      </MemoryRouter>
    );

    expect(tree).toMatchSnapshot();
  });
});
