import React, { PropTypes } from "react";
import { Route } from "react-router-dom";
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

    <Tabs panels={panels} />

    <div className="tab-container">
      <Route path="/channels/:id/monday" render={() => (
        <div id="monday" className="tabpanel" role="tabpanel" aria-labelledby="monday-tab" aria-hidden="false">
          <table>
            <thead>
              <tr>
                <th>Time Slot</th>
                <th>Recurrence</th>
                <th>Collection</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>03:30</td>
                <td><select><option selected>Only Mondays</option></select></td>
                <td><select><option selected>My first collection</option></select></td>
              </tr>
              <tr>
                <td>04:30</td>
                <td><select><option selected>Everyday</option></select></td>
                <td><select><option selected>My first collection</option></select></td>
              </tr>
              <tr>
                <td>05:30</td>
                <td><select><option selected>Everyday</option></select></td>
                <td><select><option selected>My first collection</option></select></td>
              </tr>
            </tbody>
          </table>
        </div>
      )} />
    </div>
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
