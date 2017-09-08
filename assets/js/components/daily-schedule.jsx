// @flow

import React from "react";
import { dayTranslations } from "lib/schedule-helpers";
import Icon from "../components/icon";
import LinkButton from "../components/ui/link-button";

type DailyScheduleProps = {
  timeslots: Array<{
    id: string,
    time: string,
    recurrence: string,
    collection: {
      name: string
    }
  }>,
  handleRemove: string => void
};

const DailySchedule = ({ timeslots, handleRemove }: DailyScheduleProps) =>
  <table className="daily-schedule">
    <thead>
      <tr className="timeslot">
        <th className="timeslot_time">Time Slot</th>
        <th className="timeslot_recurrence">Recurrence</th>
        <th className="timeslot_collection">Collection</th>
        <th className="timeslot_actions" />
      </tr>
    </thead>
    <tbody>
      {timeslots.map(
        ({ id, time, recurrence, collection: { name: collectionName } }) =>
          <tr className="timeslot" key={id}>
            <td className="timeslot_time">{time.slice(0, 5)}</td>
            <td className="timeslot_recurrence">
              {dayTranslations[recurrence]}
            </td>
            <td className="timeslot_collection">{collectionName}</td>
            <td className="timeslot_actions">
              <LinkButton
                className="timeslot__remove-action"
                onClick={() => handleRemove(id)}
              >
                <Icon name="remove" />
              </LinkButton>
            </td>
          </tr>
      )}
    </tbody>
  </table>;

export default DailySchedule;
