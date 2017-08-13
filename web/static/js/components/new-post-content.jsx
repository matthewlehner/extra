// @flow
import React, { Component } from "react";
import type { NewPostContentProps } from "../app/pages/new-post-content";

import postContentFormData, { updateInput } from "lib/new-post-content-form";
import type { PostContentFormData } from "lib/new-post-content-form";

import Modal from "./modal";
import PostEditor from "./forms/post-editor.jsx";
import PostContentForm from "./forms/post-content";

export default class NewPostContent extends Component {
  props: NewPostContentProps;

  constructor(props: NewPostContentProps) {
    super(props);
    const { channels } = props.data;
    this.state = { formData: postContentFormData(channels) };
  }

  onCancel = (): void => {
    const { history, match: { params } } = this.props;
    history.push(`/collections/${params.id}`);
  };

  addPostContent = (formData): Promise<*> => {
    const variables: AddPostContentMutationVariables = {
      ...formData,
      collectionId: this.props.match.params.id
    };

    return this.props.addPostContent({ variables }).then(response => {
      this.onCancel();
    });
  };

  render() {
    const { data: { loading, error, channels, collection } } = this.props;

    return (
      <Modal title="Create new post" onDismiss={this.onCancel}>
        {loading
          ? "Loading"
          : error
            ? error.message
            : <PostEditor
                handleCancel={this.onCancel}
                persistPost={this.addPostContent}
                post={defaultPostContent}
                channels={channels}
                collection={collection}
              />}
      </Modal>
    );
  }
}

const defaultPostContent = {
  body: "",
  channels: []
};
