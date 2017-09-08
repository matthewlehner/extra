// @flow
import React, { Component } from "react";
import type { NewPostContentProps } from "../app/pages/new-post-content";

import postContentFormData, { updateInput } from "lib/new-post-content-form";
import type { PostContentFormData } from "lib/new-post-content-form";

import Modal from "./modal";
import ContentEditor from "./forms/content-editor.jsx";

export default class NewPostContent extends Component {
  props: NewPostContentProps;

  onDismiss = (event: ?SyntheticEvent): void => {
    if (event) {
      event.preventDefault();
    }

    const { history, match: { params } } = this.props;
    history.push(`/collections/${params.id}`);
  };

  handleSubmit = (values): Promise<*> => {
    const { onAddContent, match: { params } } = this.props;
    const input = { collectionId: params.id, ...values };
    return onAddContent(input).then(response => {
      this.onDismiss();
      return response;
    });
  };

  render() {
    const { data: { loading, error, channels, collection } } = this.props;

    return (
      <Modal title="Add Content" onDismiss={this.onDismiss}>
        {loading
          ? "Loading"
          : error
            ? error.message
            : <ContentEditor
                handleCancel={this.onDismiss}
                persistContent={this.handleSubmit}
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
