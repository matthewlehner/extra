// @flow

import React from "react";
import { dayTranslations } from "lib/schedule-helpers";

type DailyScheduleProps = {
  timeslots: Array<{
    id: string,
    time: string,
    recurrence: string,
    collection: {
      name: string
    }
  }>
};

const DailySchedule = ({ timeslots } :DailyScheduleProps) => (
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

export default DailySchedule;
