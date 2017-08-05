// @flow
import React from "react";
import { Formik } from "formik";
import yup from "yup";

import LinkButton from "components/ui/link-button";
import { Select } from "lib/forms";
import { dayTranslations } from "lib/schedule-helpers";

const recurrenceOptions = ({ name }) => ({
  value: name,
  label: dayTranslations[name]
});

const collectionOptions = ({ id, name }) => ({ value: id, label: name });

const TimeslotForm = ({
  onCancel,
  recurrences,
  collections,

  values,
  touched,
  errors,
  dirty,
  isSubmitting,
  handleChange,
  handleBlur,
  handleSubmit,
  handleReset
}) =>
  <form onSubmit={handleSubmit} className="timeslot_form">
    <div className="timeslot_controls">
      <div className="timeslot_time">
        <input
          name="time"
          type="text"
          placeholder="00:00"
          value={values.time}
          onChange={handleChange}
          onBlur={handleBlur}
          required
        />
      </div>

      <div className="timeslot_recurrence">
        <Select
          name="recurrence"
          value={values.recurrence}
          options={recurrences.map(recurrenceOptions)}
          placeholder="—"
          required
          onChange={handleChange}
          onBlur={handleBlur}
        />
      </div>

      <div className="timeslot_collection">
        <Select
          name="collectionId"
          value={values.collectionId}
          options={collections.map(collectionOptions)}
          required
          placeholder="—"
          onChange={handleChange}
          onBlur={handleBlur}
        />
      </div>
    </div>

    <div className="form_actions">
      <LinkButton>Add Timeslot</LinkButton>
      <LinkButton onClick={onCancel}>Cancel</LinkButton>
    </div>
  </form>;

const formLogic = Formik({
  mapPropsToValues: props => {
    return {
      time: "",
      collectionId: "",
      recurrence: ""
    };
  },
  validationSchema: yup.object().shape({
    time: yup
      .string()
      .matches(
        /^\d{1,2}:\d{2}$/,
        "Must be in 24 hour format, with a colon to separate hour from minutes"
      )
      .required(),
    recurrence: yup.string().required(),
    collectionId: yup.string().required()
  }),

  handleSubmit: (values, { props }) => {
    props.onAddTimeslot(values);
  }
});

export default formLogic(TimeslotForm);
