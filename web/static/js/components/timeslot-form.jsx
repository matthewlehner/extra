import React, { PropTypes } from "react";

import Select from "components/forms/select";
import { dayTranslations } from "lib/schedule-helpers";

const TimeslotForm = ({ time, recurrence, collection, onCancel, onSubmit }) => (
  <form onSubmit={onSubmit}>
    <input
      type="text" placeholder="00:00" value={time.value}
      onChange={time.onChange}
    />
    <Select onChange={recurrence.onChange} value={recurrence.value}>
      {recurrence.options.map(({ name }) => (
        <option key={name} value={name}>{dayTranslations[name]}</option>
      ))}
    </Select>
    <Select onChange={collection.onChange} value={collection.value}>
      {collection.options.map(({ id, name }) => (
        <option key={id} value={id}>{name}</option>
      ))}
    </Select>

    <button onClick={onSubmit}>Add Timeslot</button>
    <button onClick={onCancel}>Cancel</button>
  </form>
);

const selectPropType = PropTypes.shape({
  options: PropTypes.array.isRequired,
  value: PropTypes.oneOfType([PropTypes.string, PropTypes.number]).isRequired,
  onChange: PropTypes.func.isRequired
});

const inputPropType = PropTypes.shape({
  value: PropTypes.oneOfType([PropTypes.string, PropTypes.number]).isRequired,
  onChange: PropTypes.func.isRequired
});

TimeslotForm.propTypes = {
  time: inputPropType.isRequired,
  recurrence: selectPropType.isRequired,
  collection: selectPropType.isRequired,
  onCancel: PropTypes.func.isRequired,
  onSubmit: PropTypes.func.isRequired
};

export default TimeslotForm;
