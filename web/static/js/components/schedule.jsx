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

type ScheduleArgs = {
  schedule: {
    id: string,
    autopilot: boolean,
    timeslots: Array<Timeslot>
  },
  toggleAutopilot: Function
};

function panels(timeslots: Array<Timeslot>) {
  return daysOfTheWeek.map(day => ({
    label: day,
    content: <DailySchedule day={day} timeslots={timeslotsFor(day, timeslots)} />
  }));
}

const Schedule = (
  { schedule: { id, autopilot, timeslots }, toggleAutopilot }: ScheduleArgs
) => (
  <section className="channel-schedule">
    <h2>Schedule</h2>

    <p>
      <ToggleSwitch
        checked={autopilot}
        onChange={toggleAutopilot}
      />
      <strong>Schedule autopilot.</strong> Great for beginners and those with
      massive collections.
    </p>

    <Tabs name={"schedule"} panels={panels(timeslots)}>
      <NewTimeslot scheduleId={id} />
    </Tabs>
  </section>
);

export default Schedule;
