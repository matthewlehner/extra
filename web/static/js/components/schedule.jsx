import React, { PropTypes } from "react";
import ToggleSwitch from "./forms/toggle-switch";
import Tabs from "./tabs";
import DailySchedule from "./daily-schedule";

const panels = [{
  label: "Monday",
  content: <DailySchedule day={"Monday"} />
}, {
  label: "Tuesday",
  content: <DailySchedule day={"Tuesday"} />
}, {
  label: "Wednesday",
  content: <DailySchedule day={"Wednesday"} />
}, {
  label: "Thursday",
  content: <DailySchedule day={"Thursday"} />
}, {
  label: "Friday",
  content: <DailySchedule day={"Friday"} />
}, {
  label: "Saturday",
  content: <DailySchedule day={"Saturday"} />
}, {
  label: "Sunday",
  content: <DailySchedule day={"Sunday"} />
}];

const Schedule = props => (
  <section className="channel-schedule">
    <h2>Schedule</h2>

    <p>
      <ToggleSwitch
        checked={props.autopilot}
        onChange={props.toggleAutopilot}
      />
      <strong>Schedule autopilot.</strong> Great for beginners and those with
      massive collections.
    </p>

    <Tabs name={"schedule"} panels={panels} />
  </section>
);

Schedule.propTypes = {
  autoPilot: PropTypes.bool,
  toggleAutopilot: PropTypes.func.isRequired
};

Schedule.defaultProps = {
  autoPilot: true
};

export default Schedule;
