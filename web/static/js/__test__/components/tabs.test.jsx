import React from "react";
import renderer from "react-test-renderer";

import Tabs from "components/tabs";

const panels = [{
  label: "Monday",
  content: "hi bud"
}, {
  label: "Tuesday",
  content: "great day"
}];

describe("Tabs", () => {
  it("renders tabs", () => {
    const props = { panels };
    const tree = renderer.create(<Tabs {...props} />);

    expect(tree).toMatchSnapshot();
  });

  it("can specify active panel", () => {
    const props = {
      activePanel: panels[1].label,
      panels
    };
    const tree = renderer.create(<Tabs {...props} />);

    expect(tree).toMatchSnapshot();
  });

  describe("interactions", () => {
    it("switches panes", () => {
      const props = { panels };
      const component = renderer.create(<Tabs {...props} />);
      let tree = component.toJSON();
      expect(tree).toMatchSnapshot();

      tree.children[0].children[1].props.onClick();

      tree = component.toJSON();
      expect(tree).toMatchSnapshot();
    });
  });
});
