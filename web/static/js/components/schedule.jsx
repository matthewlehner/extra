import React, { PropTypes } from "react";
import ToggleSwitch from "./forms/toggle-switch";
import Tabs from "./tabs";
import DailySchedule from "./daily-schedule";

import { timeslotsFor, daysOfTheWeek } from "../lib/schedule-helpers";

function panels(timeslots) {
  return daysOfTheWeek.map(day => ({
    label: day,
    content: <DailySchedule day={day} timeslots={timeslotsFor(day, timeslots)} />
  }));
}

const Schedule = ({ autopilot, toggleAutopilot, timeslots }) => (
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

    <Tabs name={"schedule"} panels={panels(timeslots)} />
    { autopilot ? "Add new time slot" : null }
  </section>
);

Schedule.propTypes = {
  autopilot: PropTypes.bool.isRequired,
  toggleAutopilot: PropTypes.func.isRequired,
  timeslots: PropTypes.arrayOf(PropTypes.shape({
    recurrence: PropTypes.string.isRequired,
    time: PropTypes.string.isRequired,
    collection: PropTypes.shape({
      name: PropTypes.string.isRequired
    }).isRequired
  })).isRequired
};

export default Schedule;
