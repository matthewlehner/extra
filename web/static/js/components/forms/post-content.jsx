// @flow
import React, { Component } from "react";
import { Link } from "react-router-dom";

import postContentFormData, {
  updateInput
} from "lib/new-post-content-form";
import type { PostContentFormData } from "lib/new-post-content-form";

import {
  Form,
  Field,
  Select,
  Textarea,
  CheckboxCollection
} from "lib/forms";

type Props = {
  cancelPath: string,
  collections: Array<PostCollection>,
  channels: Array<Channel>,
  addPostContent: ({
    variables: {
      body: string, collectionId: string, channelIds: Array<string>
    }
  }) => void
};

class PostContentForm extends Component {
  props: Props;

  state: {
    form: PostContentFormData
  }

  constructor(props: Props) {
    super(props);

    this.state = {
      form: postContentFormData(props.collections, props.channels)
    };
  }

  onChangeInput = (field: string, value: string | {}) => {
    this.setState(({ form }) => ({
      form: updateInput(field, value, form)
    }));
  }

  addPostContent = () => {
    const { inputs } = this.state.form;
    const variables : {
      body: string,
      collectionId: string,
      channelIds: Array<string>
    } = {
      body: inputs.content.value,
      collectionId: inputs.collection.value || this.props.collections[0].id,
      channelIds: Object.keys(inputs.channels.value).filter(id => inputs.channels.value[id])
    };

    this.props.addPostContent({ variables });
  }

  render() {
    const { cancelPath } = this.props;
    const {
      form: {
        inputs: { collection, content, channels }
      }
    } = this.state;

    return (
      <Form onSubmit={this.addPostContent}>
        <Field label={collection.label}>
          <Select
            fieldName="collection"
            options={collection.options}
            value={collection.value}
            onChange={this.onChangeInput}
          />
        </Field>
        <Field label={content.label}>
          <Textarea
            fieldName="content"
            id="post_content_body"
            name="post_content[body]"
            value={content.value}
            onChange={this.onChangeInput}
          />
        </Field>

        <div className="form__control-group">
          <span className="form__control-label">{channels.label}</span>
          <CheckboxCollection
            fieldName="channels"
            onChange={this.onChangeInput}
            value={channels.value}
            options={channels.options}
          />
        </div>

        <div className="form__actions">
          <Link className="button button_cancel" to={cancelPath}>
            Cancel
          </Link>
          <button className="button" type="submit">
            Create Post
          </button>
        </div>
      </Form>
    );
  }
}

export default PostContentForm;
