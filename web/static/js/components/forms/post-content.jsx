// @flow
import React from "react";

import type { PostContentFormData } from "lib/new-post-content-form";

import {
  Form,
  Field,
  Select,
  Textarea,
  CheckboxCollection
} from "lib/forms";

type Props = {
  onCancel: () => void,
  onChangeInput: (string, string) => void,
  formData: PostContentFormData,
  addPostContent: () => Promise<*>
};

const PostContentForm = ({
  formData: {
    inputs: { collection, content, channels },
    isSaving
  },
  onChangeInput,
  onCancel,
  addPostContent
}: Props) => (
  <Form onSubmit={addPostContent}>
    <Field label={collection.label}>
      <Select
        name="collection"
        options={collection.options}
        value={collection.value}
        onChange={onChangeInput}
        required
      />
    </Field>
    <Field label={content.label}>
      <Textarea
        name="content"
        value={content.value}
        onChange={onChangeInput}
        required
      />
    </Field>

    <div className="form__control-group">
      <span className="form__control-label">{channels.label}</span>
      <CheckboxCollection
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
  </Form>
);

export default PostContentForm;
