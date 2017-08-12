// @flow
import React from "react";
import { Formik } from "formik";
import { object, string } from "yup";

import { label, inputContainer } from "../../lib/forms/form.scss";

import { Textarea, ChannelSelector } from "../../lib/forms";

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
  <form onSubmit={handleSubmit}>
    <dl className="form__control-group">
      <dt className={label}>Collection</dt>
      <dd className={inputContainer}>Collection Name</dd>
    </dl>

    <div className="form__control-group">
      <label className={label} htmlFor="post-content">
        Content
      </label>
      <Textarea
        id="post-content"
        name="body"
        value={values.body}
        onChange={handleChange}
        required
      />
      {errors.body &&
        touched.body &&
        <div>
          {errors.body}
        </div>}
    </div>

    <div className="form__control-group">
      <span className={label}>Channels</span>
      <ChannelSelector
        name="channels"
        value={values.channels}
        options={channels}
        onChange={setFieldValue}
      />
      {errors.channels &&
        touched.body &&
        <div>
          {errors.body}
        </div>}
    </div>

    <div className="form__actions">
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
    {
      props: { onUpdatePost, post: { id }, handleCancel },
      setErrors,
      setSubmitting
    }
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

    persistPost({ variables: { input } }).then(
      response => {
        setSubmitting(false);
        handleCancel();
      },
      error => {
        setSubmitting(false);
        setErrors(error);
      }
    );
  }
})(PostEditor);
