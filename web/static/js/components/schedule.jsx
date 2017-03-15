import React, { PropTypes } from "react";
import ToggleSwitch from "./forms/toggle-switch";
import Tabs from "./tabs";

const panels = [{
  label: "Monday",
  content: "hi guys."
}, {
  label: "Tuesday",
  content: (<div>Here’s some content</div>)
}];

const Schedule = props => (
  <section className="channel-schedule">
    <h2>Schedule</h2>

    <p>
      <ToggleSwitch
        checked={props.autoPilot}
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
