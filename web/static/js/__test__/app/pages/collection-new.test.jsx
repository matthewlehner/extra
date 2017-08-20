// @flow
import React from "react";
import renderer from "react-test-renderer";

import CollectionNewPage from "app/components/new-collection";

describe("CollectionNewPage component", () => {
  it("renders correctly", () => {
    const tree = renderer.create(<CollectionNewPage />);

    expect(tree).toMatchSnapshot();
  });
});
