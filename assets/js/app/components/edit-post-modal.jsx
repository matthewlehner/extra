// @flow
import React, { PureComponent } from "react";
import type { EditPostProps } from "../pages/edit-post-content";

import Modal from "../../components/modal";
import ContentEditor from "../../components/forms/content-editor";

class EditContentModal extends PureComponent {
  props: EditPostProps;

  onDismiss = (event: ?SyntheticEvent): void => {
    if (event) {
      event.preventDefault();
    }

    const { history, match: { params: { collectionId } } } = this.props;
    history.push(`/collections/${collectionId}`);
  };

  handleSubmit = params => {
    const {
      onUpdateContent,
      match: { params: { postId, collectionId } },
      history
    } = this.props;
    const input = { id: postId, ...params };
    return onUpdateContent(input).then(content => {
      this.onDismiss();
      return content;
    });
  };

  render() {
    const { data: { loading, error, postContent, channels } } = this.props;

    return (
      <Modal title="Edit Content" onDismiss={this.onDismiss}>
        {loading
          ? "Loading"
          : error
            ? error.message
            : <ContentEditor
                handleCancel={this.onDismiss}
                persistContent={this.handleSubmit}
                post={postContent}
                collection={postContent.collection}
                channels={channels}
              />}
      </Modal>
    );
  }
}

export default EditContentModal;
