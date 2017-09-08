// @flow
import React from "react";
import renderer from "react-test-renderer";

import ChannelNewPage from "app/pages/channel-new";

describe("ChannelNewPage component", () => {
  it("renders correctly", () => {
    const tree = renderer.create(<ChannelNewPage />);

    expect(tree).toMatchSnapshot();
  });
});
