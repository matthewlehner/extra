// @flow
import React, { Component } from "react";
import { Link } from "react-router-dom";

import postContentFormData from "lib/new-post-content-form";
import type { PostContentFormData } from "lib/new-post-content-form";

import {
  Field,
  Select,
  Textarea,
  CheckboxCollection
} from "lib/forms";

class PostContentForm extends Component {
  props: {
    cancelPath: string,
    collections: Array<{
      id: string,
      name: string
    }>,
    channels: Array<{
      id: string,
      name: string,
      provider: string
    }>
  };

  state: {
    form: PostContentFormData
  }

  componentWillMount() {
    this.setState((nextState, { collections, channels }) => ({
      form: postContentFormData(collections, channels)
    }));
  }

  render() {
    const { cancelPath } = this.props;
    const { form: { inputs: { collection, content, channels } } } = this.state;

    return (
      <form>
        <Field label={collection.label}>
          <Select options={collection.options} />
        </Field>
        <Field label={content.label}>
          <Textarea id="post_content_body" name="post_content[body]" />
        </Field>

        <div className="form__control-group">
          <span className="form__control-label">{channels.label}</span>
          <CheckboxCollection options={channels.options} />
        </div>

        <div className="form__actions">
          <Link className="button button_cancel" to={cancelPath}>
            Cancel
          </Link>
          <button className="button" type="submit">
            Create Post
          </button>
        </div>
      </form>
    );
  }
}

export default PostContentForm;
