// @flow

import React from "react";
import renderer from "react-test-renderer";

import NewTimeslot from "components/new-timeslot";

describe("NewTimeslot component", () => {
  it("renders the component", () => {
    const tree = renderer.create(
      <NewTimeslot
        addTimeslot={jest.fn()}
        scheduleId={"1"}
        collections={[]}
        recurrenceType={{ enumValues: [] }}
      />
    );
    expect(tree).toMatchSnapshot();
  });
});
