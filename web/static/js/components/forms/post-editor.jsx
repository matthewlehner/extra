// @flow
import React from "react";
import { Formik } from "formik";
import { object, array, string } from "yup";

import {
  gridForm,
  gridLabel,
  gridControl,
  gridRow
} from "../../lib/forms/form.scss";
import { ChannelSelector } from "../../lib/forms";

type Props = {
  channels: Extra$Channel,
  values: {
    body: string,
    channels: Array<{}>
  },
  handleChange: () => void,
  handleSubmit: () => void,
  handleCancel: () => void,
  isSubmitting: boolean
};

const PostEditor = ({
  channels,
  values,
  handleChange,
  handleSubmit,
  handleCancel,
  isSubmitting
}: Props) =>
  <form className={gridForm} onSubmit={handleSubmit}>
    <dl className={`${gridForm} ${gridRow}`}>
      <dt className={gridLabel}>Collection</dt>
      <dd className={gridControl}>Collection Name</dd>
    </dl>

    <label className={gridLabel} htmlFor="post-content">
      Content
    </label>
    <textarea
      id="post-content"
      className={gridControl}
      value={values.body}
      onChange={handleChange}
      required
    />

    <span className={gridLabel}>Channels</span>
    <ChannelSelector
      name="channels"
      className={gridControl}
      value={values.channels}
      options={channels}
    />

    <div className={`form__actions ${gridRow}`}>
      <button
        className="button button_cancel"
        disabled={isSubmitting}
        onClick={handleCancel}
      >
        Cancel
      </button>
      <button className="button" type="submit" disabled={isSubmitting}>
        Create Post
      </button>
    </div>
  </form>;

export default Formik({
  validationSchema: object().shape({
    channels: array(object()),
    body: string().required()
  }),

  mapPropsToValues: ({ post: { body, channels } }) => ({
    body,
    channels: channels.reduce(
      (values, { id }) => ({ ...values, [id]: true }),
      {}
    )
  })
})(PostEditor);
