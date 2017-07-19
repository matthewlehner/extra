// @flow
import React from "react";
import { Formik } from "formik";
import { object, string } from "yup";

import { form, formActions } from "../../components/account.scss";

const UserPasswordForm = ({
  error,
  values,
  handleChange,
  handleSubmit,
  handleBlur,
  isSubmitting
}) =>
  <form className={form} onSubmit={handleSubmit}>
    {error &&
      error.message &&
      <div style={{ color: "red" }}>
        {error.message}
      </div>}
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
  handleSubmit: (payload, { props, setError, setSubmitting, resetForm }) => {
    props.updatePassword(payload).then(
      ({
        data: { updatePassword: { userErrors, user } }
      }: {
        data: UpdatePasswordMutation
      }) => {
        setSubmitting(false);
        if (userErrors.length > 0) {
          setError(userErrors[0]);
        } else {
          resetForm();
        }
      },
      error => {
        setSubmitting(false);
        setError(error);
      }
    );
  }
})(UserPasswordForm);
