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
  setFieldValue: () => void,
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
  setFieldValue,
  isSubmitting,
  errors,
  touched
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
      name="body"
      className={gridControl}
      value={values.body}
      onChange={handleChange}
      required
    />
    {errors.body && touched.body && <div>{errors.body}</div>}

    <span className={gridLabel}>Channels</span>
    <ChannelSelector
      name="channels"
      className={gridControl}
      value={values.channels}
      options={channels}
      onChange={setFieldValue}
    />
    {errors.channels && touched.body && <div>{errors.body}</div>}

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
    channels: object(),
    body: string().required()
  }),

  mapPropsToValues: ({ post: { body, channels } }) => ({
    body,
    channels: channels.reduce(
      (values, { id }) => ({ ...values, [id]: true }),
      {}
    )
  }),
  handleSubmit: (
    values,
    { props: { onUpdatePost, post: { id } }, setErrors, setSubmitting }
  ) => {
    const { body, channels } = values;
    const channelIds = Object.keys(channels).reduce((collector, channelId) => {
      if (channels[channelId]) {
        return [...collector, channelId];
      } else {
        return collector;
      }
    }, []);

    const input = { id, body, channelIds };

    onUpdatePost({ variables: { input } }).then(
      response => {
        setSubmitting(false);
      },
      error => {
        setSubmitting(false);
        debugger;
        setErrors(error);
      }
    );
  }
})(PostEditor);
