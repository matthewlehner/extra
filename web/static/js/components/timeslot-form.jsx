// @flow

import React from "react";

import LinkButton from "components/ui/link-button";
import { Select, Input } from "lib/forms";
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

type Props = {
  time: InputPropsType,
  recurrence: SelectPropsType,
  collection: SelectPropsType,
  onCancel: Function,
  onSubmit: Function
};

const recurrenceOptions = ({ name }) => ({
  value: name,
  label: dayTranslations[name]
});

const collectionOptions = ({ id, name }) => ({ value: id, label: name });

const TimeslotForm = ({
  time,
  recurrence,
  collection,
  onCancel,
  onSubmit
}: Props) => (
  <form onSubmit={onSubmit}>
    <Input
      name="time"
      type="text"
      placeholder="00:00"
      value={time.value}
      onChange={time.onChange}
      required
    />
    <Select
      name="recurrence"
      onChange={recurrence.onChange}
      value={recurrence.value}
      options={recurrence.options.map(recurrenceOptions)}
      placeholder="—"
      required
    />
    <Select
      name="collectionId"
      onChange={collection.onChange}
      value={collection.value}
      options={collection.options.map(collectionOptions)}
      required
      placeholder="—"
    />

    <LinkButton onClick={onSubmit}>Add Timeslot</LinkButton>
    <LinkButton onClick={onCancel}>Cancel</LinkButton>
  </form>
);

export default TimeslotForm;
