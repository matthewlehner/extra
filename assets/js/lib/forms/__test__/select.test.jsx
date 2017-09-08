// @flow
import React from "react";
import renderer from "react-test-renderer";

import Select from "../select";

describe("Select component", () => {
  const options = [{ value: "1", label: "Inspirational Posts" }];
  const name = "post_content[post_collection_id]";
  const onChange = jest.fn();

  it("renders correctly", () => {
    const tree = renderer.create(
      <Select options={options} name={name} onChange={onChange} />
    );

    expect(tree).toMatchSnapshot();
  });

  it("displays placeholder", () => {
    const tree = renderer.create(
      <Select
        options={options}
        name={name}
        onChange={onChange}
        placeholder="Select something"
      />
    );

    expect(tree).toMatchSnapshot();
  });

  it("hides placeholder when value is present", () => {
    const tree = renderer.create(
      <Select
        options={options}
        name={name}
        onChange={onChange}
        value={options[0].value}
        placeholder="Select something"
      />
    );

    expect(tree).toMatchSnapshot();
  });
});
