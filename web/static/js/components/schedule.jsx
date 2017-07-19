// @flow

import React from "react";
import { timeslotsFor, daysOfTheWeek } from "lib/schedule-helpers";

import ToggleSwitch from "./forms/toggle-switch";
import Tabs from "./tabs";
import DailySchedule from "./daily-schedule";
import NewTimeslot from "./new-timeslot";

export type Timeslot = {
  recurrence: string,
  time: string,
  collection: {
    name: string
  }
};

function panels(timeslots: Array<Timeslot>, removeTimeslot) {
  return daysOfTheWeek.map(day => ({
    label: day,
    content: (
      <DailySchedule
        day={day}
        timeslots={timeslotsFor(day, timeslots)}
        handleRemove={removeTimeslot}
      />
    )
  }));
}

const Schedule = ({
  toggleAutopilot,
  addTimeslot,
  removeTimeslot,
  schedule: { id, autopilot, timeslots },
  collections,
  recurrenceType
}: ChannelPageQuery) =>
  <section className="channel-schedule">
    <h2>Schedule</h2>

    <p>
      <ToggleSwitch checked={autopilot} onChange={toggleAutopilot} />
      <strong>Schedule autopilot.</strong> Great for beginners and those with
      massive collections.
    </p>

    <Tabs name={"schedule"} panels={panels(timeslots, removeTimeslot)}>
      <NewTimeslot
        scheduleId={id}
        addTimeslot={addTimeslot}
        collections={collections}
        recurrenceType={recurrenceType}
      />
    </Tabs>
  </section>;

export default Schedule;
