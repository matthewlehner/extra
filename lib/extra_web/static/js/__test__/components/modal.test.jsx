import React from "react";
import renderer from "react-test-renderer";
import { MemoryRouter } from "react-router-dom";

import Modal from "components/modal";

describe("Modal component", () => {
  it("renders properly", () => {
    const tree = renderer.create(
      <MemoryRouter>
        <Modal onDismiss={jest.fn()} cancelPath="a string" />
      </MemoryRouter>
    );

    expect(tree).toMatchSnapshot();
  });

  it("renders with children", () => {
    const tree = renderer.create(
      <MemoryRouter>
        <Modal onDismiss={jest.fn()} cancelPath="a string">
          I’m a child element!
        </Modal>
      </MemoryRouter>
    );

    expect(tree).toMatchSnapshot();
  });
});
