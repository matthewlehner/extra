// @flow

import React from "react";
import {
  timeslotsFor,
  daysOfTheWeek,
  orderTimeslots
} from "lib/schedule-helpers";

import Tabs from "./tabs";
import DailySchedule from "./daily-schedule";
import NewTimeslot from "./new-timeslot";
import TimezoneForm from "../app/components/timezone-form";

export type Timeslot = {
  recurrence: string,
  time: string,
  collection: {
    name: string
  }
};

function panels(timeslots: Array<Timeslot>, removeTimeslot) {
  const sortedTimeslots = orderTimeslots(timeslots);
  return daysOfTheWeek.map(day => ({
    label: day,
    content: (
      <DailySchedule
        day={day}
        timeslots={timeslotsFor(day, sortedTimeslots)}
        handleRemove={removeTimeslot}
      />
    )
  }));
}

const Schedule = ({
  addTimeslot,
  removeTimeslot,
  updateSchedule,
  schedule: { id, timezone, timeslots },
  collections,
  recurrenceType
}: ChannelPageQuery) =>
  <section className="channel-schedule">
    <TimezoneForm timezone={timezone} updateSchedule={updateSchedule} />

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
