import React, { PropTypes } from "react";
import { dayTranslations } from "lib/schedule-helpers";

const DailySchedule = ({ day, timeslots }) => {
  const times = timeslots.map(
    ({ id, time, recurrence, collection: { name: collectionName } }) => (
      <tr key={`${day}-${id}`}>
        <td>{time.slice(0, 5)}</td>
        <td>{dayTranslations[recurrence]}</td>
        <td>{collectionName}</td>
      </tr>
    )
  );

  return (
    <div>
      <table>
        <thead>
          <tr>
            <th>Time Slot</th>
            <th>Recurrence</th>
            <th>Collection</th>
          </tr>
        </thead>
        <tbody>
          {times}
        </tbody>
      </table>
      Add new time slot
    </div>
  );
};

DailySchedule.propTypes = {
  day: PropTypes.string.isRequired,
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
