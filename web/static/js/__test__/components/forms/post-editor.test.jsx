// @flow
import React from "react";
import renderer from "react-test-renderer";

import PostEditor from "../../../components/forms/post-editor";

describe("<PostEditor />", () => {
  const props = { channels: [], post: { body: {}, channels: [] } };

  it("renders without crashing", () => {
    const tree = renderer.create(<PostEditor {...props} />);

    expect(tree).toMatchSnapshot();
  });
});
