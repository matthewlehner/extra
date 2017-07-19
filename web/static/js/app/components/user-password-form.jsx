// @flow
import React from "react";
import { Formik } from "formik";
import { object, string } from "yup";

import { form, formActions } from "../../components/account.scss";

const UserPasswordForm = ({
  values,
  handleChange,
  handleSubmit,
  handleBlur,
  isSubmitting
}) =>
  <form className={form} onSubmit={handleSubmit}>
    <label htmlFor="user[current_password]">Current password</label>
    <input
      id="user[current_password]"
      name="current"
      type="password"
      defaultValue=""
      value={values.password}
      onChange={handleChange}
      onBlur={handleBlur}
      required
    />

    <label htmlFor="user[new_password]">New password</label>
    <input
      id="user[new_password]"
      name="new"
      type="password"
      defaultValue=""
      value={values.nextPassword}
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
    current: string().required(),
    new: string().required()
  }),
  handleSubmit: (payload, { props, setError, setSubmitting, handleReset }) => {
    props.updatePassword(payload).then(
      res => {
        setSubmitting(false);
        handleReset();
      },
      error => {
        setSubmitting(false);
        setError(error);
      }
    );
  }
})(UserPasswordForm);
