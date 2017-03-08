import React, { PropTypes } from "react";
import ToggleSwitch from "components/forms/toggle-switch";

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
