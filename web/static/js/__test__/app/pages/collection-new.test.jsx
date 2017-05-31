// @flow
import React from "react";
import renderer from "react-test-renderer";

import CollectionNewPage from "app/pages/collection-new";

describe("CollectionNewPage component", () => {
  it("renders correctly", () => {
    const tree = renderer.create(<CollectionNewPage />);

    expect(tree).toMatchSnapshot();
  });
});
