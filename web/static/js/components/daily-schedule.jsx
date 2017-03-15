import React, { PropTypes } from "react";

const DailySchedule = ({ day }) => (
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
        <td><select><option selected>Only {day}s</option></select></td>
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
);

DailySchedule.propTypes = {
  day: PropTypes.string.isRequired
};

export default DailySchedule;
