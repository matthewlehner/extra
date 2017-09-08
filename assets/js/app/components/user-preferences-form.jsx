// @flow
import React from "react";
import { Formik } from "formik";
import { object, string } from "yup";
import { Select } from "../../lib/forms";
import timezones, { validTimezones } from "../../lib/timezones";

import { form, formActions } from "../../components/account.scss";

const UserPreferencesForm = ({
  values,
  handleChange,
  handleSubmit,
  handleBlur,
  isSubmitting
}) =>
  <form className={form} onSubmit={handleSubmit}>
    <label htmlFor="user[email_address]">Email address</label>
    <input
      id="user[email_address]"
      name="email"
      type="email"
      value={values.email}
      onChange={handleChange}
      onBlur={handleBlur}
      required
    />

    <label htmlFor="user[timezone]">Timezone</label>
    <Select
      id="user[timezone]"
      name="timezone"
      options={timezones}
      placeholder=" "
      value={values.timezone}
      onChange={handleChange}
      onBlur={handleBlur}
      required
    />

    <div className={formActions}>
      <button className="button" disabled={isSubmitting}>
        {isSubmitting ? "Saving" : "Update"}
      </button>
    </div>
  </form>;

export default Formik({
  validationSchema: object().shape({
    email: string().email().required(),
    timezone: string().required().oneOf(validTimezones())
  }),
  mapPropsToValues: ({ formData: { email, timezone } }) => ({
    email,
    timezone
  }),
  handleSubmit: (payload, { props, setError, setSubmitting }) => {
    props.updatePreferences(payload).then(
      res => {
        setSubmitting(false);
      },
      error => {
        setSubmitting(false);
        setError(error);
      }
    );
  }
})(UserPreferencesForm);
