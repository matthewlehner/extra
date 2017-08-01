// @flow
import React from "react";
import { Formik } from "formik";
import { object, string } from "yup";

import { form, formActions } from "../../components/account.scss";
import { Link } from "react-router-dom";

const CollectionForm = ({
  collection: { id },
  values,
  errors,
  touched,
  dirty,
  handleBlur,
  handleCancel,
  handleChange,
  handleSubmit,
  isSubmitting
}) =>
  <form className={form} onSubmit={handleSubmit}>
    <label htmlFor="collection[name]">Collection Name</label>
    <input
      id="collection[name]"
      name="name"
      value={values.name}
      onChange={handleChange}
      onBlur={handleBlur}
      required
    />
    {errors.name &&
      touched.name &&
      <div>
        {errors.name}
      </div>}

    <div className={formActions}>
      <button className="button" disabled={isSubmitting}>
        {isSubmitting ? "Saving" : id ? "Update" : "Create"}
      </button>
      {id ? <Link to={`/collections/${id}`}>Cancel</Link> : null}
    </div>
  </form>;

const collectionFormData = Formik({
  mapPropsToValues: ({ collection: { name } }) => ({
    name
  }),
  validationSchema: object().shape({
    name: string().required()
  }),
  handleSubmit: (
    payload,
    { props: { onSubmit }, setErrors, setSubmitting }
  ) => {
    onSubmit(payload).then(
      () => {},
      collectionErrors => {
        setSubmitting(false);
        const errors = collectionErrors.reduce(
          (errors, { field, message }) => ({
            ...errors,
            [field]: message
          }),
          {}
        );
        setErrors(errors);
      }
    );
  }
});

export default collectionFormData(CollectionForm);
