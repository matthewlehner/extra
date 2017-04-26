// @flow

import React from "react";

import LinkButton from "components/ui/link-button";
import Select from "components/forms/select";
import { dayTranslations } from "lib/schedule-helpers";

type InputPropsType = {
  value: string | number,
  onChange: Function
};

type SelectPropsType = {
  options: Array<any>,
  value: string | number,
  onChange: Function
};

type TimeslotFormProps = {
  time: InputPropsType,
  recurrence: SelectPropsType,
  collection: SelectPropsType,
  onCancel: Function,
  onSubmit: Function
};

const TimeslotForm = (
  { time, recurrence, collection, onCancel, onSubmit }: TimeslotFormProps
) => (
  <form onSubmit={onSubmit}>
    <input
      type="text" placeholder="00:00" value={time.value}
      onChange={time.onChange}
    />
    <Select onChange={recurrence.onChange} value={recurrence.value}>
      <option>—</option>
      {recurrence.options.map(({ name }) => (
        <option key={name} value={name}>{dayTranslations[name]}</option>
      ))}
    </Select>
    <Select onChange={collection.onChange} value={collection.value} required>
      <option>—</option>
      {collection.options.map(({ id, name }) => (
        <option key={id} value={id}>{name}</option>
      ))}
    </Select>

    <LinkButton onClick={onSubmit}>Add Timeslot</LinkButton>
    <LinkButton onClick={onCancel}>Cancel</LinkButton>
  </form>
);

export default TimeslotForm;
