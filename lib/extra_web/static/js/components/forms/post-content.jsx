// @flow
import React from "react";

import type { PostContentFormData } from "lib/new-post-content-form";

import {
  Form,
  Field,
  Textarea,
  ChannelSelector,
  Styles as FormStyles
} from "lib/forms";

type Props = {
  collection: Extra$PostCollection,
  onCancel: () => void,
  onChangeInput: (string, string) => void,
  formData: PostContentFormData,
  addPostContent: () => Promise<*>
};

const PostContentForm = ({
  collection,
  formData: { inputs: { content, channels }, isSaving },
  onChangeInput,
  onCancel,
  addPostContent
}: Props) =>
  <Form onSubmit={addPostContent}>
    <dl className="form__control-group">
      <dt className={FormStyles.label}>Collection</dt>
      <dd className={FormStyles.inputContainer}>{collection.name}</dd>
    </dl>
    <Field label={content.label}>
      <Textarea
        name="content"
        value={content.value}
        onChange={onChangeInput}
        required
      />
    </Field>

    <div className="form__control-group">
      <span className={FormStyles.label}>{channels.label}</span>
      <ChannelSelector
        name="channels"
        onChange={onChangeInput}
        value={channels.value}
        options={channels.options}
      />
    </div>

    <div className="form__actions">
      <button
        className="button button_cancel"
        onClick={onCancel}
        disabled={isSaving}
      >
        Cancel
      </button>
      <button className="button" type="submit" disabled={isSaving}>
        Create Post
      </button>
    </div>
  </Form>;

export default PostContentForm;
