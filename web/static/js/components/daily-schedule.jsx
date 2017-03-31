import React, { PropTypes } from "react";
import { dayTranslations } from "lib/schedule-helpers";

const DailySchedule = ({ timeslots }) => (
  <table>
    <thead>
      <tr>
        <th>Time Slot</th>
        <th>Recurrence</th>
        <th>Collection</th>
      </tr>
    </thead>
    <tbody>
      {timeslots.map(
        ({ id, time, recurrence, collection: { name: collectionName } }) => (
          <tr key={id}>
            <td>{time.slice(0, 5)}</td>
            <td>{dayTranslations[recurrence]}</td>
            <td>{collectionName}</td>
          </tr>
        )
      )}
    </tbody>
  </table>
);

DailySchedule.propTypes = {
  timeslots: PropTypes.arrayOf(PropTypes.shape({
    id: PropTypes.string.isRequired,
    time: PropTypes.string.isRequired,
    recurrence: PropTypes.string.isRequired,
    collection: PropTypes.shape({
      name: PropTypes.string.isRequired
    })
  })).isRequired
};

export default DailySchedule;
