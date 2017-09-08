import React from "react";
import renderer from "react-test-renderer";
import { MemoryRouter } from "react-router-dom";

import Sidebar from "components/sidebar";

describe("Sidebar component", () => {
  it("renders correctly", () => {
    const data = {
      loading: false,
      channels: [{ id: "1", name: "something else", provider: "twitter" }],
      collections: [{ id: "1", name: "something" }]
    };
    const tree = renderer.create(
      <MemoryRouter>
        <Sidebar data={data} />
      </MemoryRouter>
    );

    expect(tree).toMatchSnapshot();
  });

  it("renders loading state", () => {
    const data = {
      loading: true,
      channels: [{ id: "1", name: "something else", provider: "twitter" }],
      collections: [{ id: "1", name: "something" }]
    };
    const tree = renderer.create(
      <MemoryRouter>
        <Sidebar data={data} />
      </MemoryRouter>
    );

    expect(tree).toMatchSnapshot();
  });

  it("renders an error state", () => {
    const data = {
      error: true,
      loading: false,
      channels: [{ id: "1", name: "something else", provider: "twitter" }],
      collections: [{ id: "1", name: "something" }]
    };
    const tree = renderer.create(
      <MemoryRouter>
        <Sidebar data={data} />
      </MemoryRouter>
    );

    expect(tree).toMatchSnapshot();
  });
});
