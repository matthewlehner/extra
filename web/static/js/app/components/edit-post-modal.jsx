// @flow
import React, { PureComponent } from "react";
import type { EditPostProps } from "../pages/edit-post-content";

import Modal from "../../components/modal";
import PostEditor from "../../components/forms/post-editor";

class EditPostModal extends PureComponent {
  props: EditPostProps;

  constructor(props: EditPostProps) {
    super(props);

    this.onDismiss = this.onDismiss.bind(this);
  }

  onDismiss(event: ?SyntheticEvent): void {
    if (event) {
      event.preventDefault();
    }

    const { history, match: { params: { collectionId } } } = this.props;
    history.push(`/collections/${collectionId}`);
  }

  render() {
    const {
      data: { loading, error, postContent, channels },
      onUpdatePost
    } = this.props;

    return (
      <Modal title="Edit Post" onDismiss={this.onDismiss}>
        {loading
          ? <div>Loading</div>
          : error
            ? <div>ERROR</div>
            : <PostEditor
                handleCancel={this.onDismiss}
                onUpdatePost={onUpdatePost}
                post={postContent}
                channels={channels}
              />}
      </Modal>
    );
  }
}

export default EditPostModal;
