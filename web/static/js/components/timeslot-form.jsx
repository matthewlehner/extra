import React, { PropTypes } from "react";

import Select from "components/forms/select";
import { dayTranslations } from "lib/schedule-helpers";

const TimeslotForm = ({ recurrenceValues, collections, selectRecurrence, selectCollection, onCancel, onSubmit, values }) => (
  <form onSubmit={onSubmit}>
    <input type="text" placeholder="00:00" />
    <Select onChange={selectRecurrence} value={values.recurrence}>
      {recurrenceValues.map(({ name }) => (
        <option key={name} value={name}>
          {dayTranslations[name]}
        </option>
      ))}
    </Select>
    <Select onChange={selectCollection} value={values.collectionId}>
      {collections.map(({ id, name }) => (
        <option key={id} value={id}>{name}</option>
      ))}
    </Select>

    <button onClick={onSubmit}>Add Timeslot</button>
    <button onClick={onCancel}>Cancel</button>
  </form>
);

TimeslotForm.propTypes = {
  recurrenceValues: PropTypes.arrayOf(
    PropTypes.shape({ name: PropTypes.string.isRequired })
  ).isRequired,
  collections: PropTypes.arrayOf(
    PropTypes.shape({
      id: PropTypes.string.isRequired,
      name: PropTypes.string.isRequired
    })
  ).isRequired,
  onCancel: PropTypes.func.isRequired,
  onSubmit: PropTypes.func.isRequired
};

export default TimeslotForm;
