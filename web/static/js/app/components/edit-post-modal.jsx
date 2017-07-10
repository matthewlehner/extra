// @flow
import React from "react";
import type { EditPostProps } from "../pages/edit-post-content";

import Modal from "../../components/modal";
import PostEditor from "../../components/forms/post-editor";

const onDismiss = (event: SyntheticEvent): void => {
  event.preventDefault();

  console.log("bye!");
};

const EditPostModal = ({
  data: { loading, error, postContent, channels }
}: EditPostProps) =>
  <Modal title="Edit Post" onDismiss={onDismiss}>
    {loading
      ? <div>Loading</div>
      : error
        ? <div>ERROR</div>
        : <PostEditor
            handleCancel={onDismiss}
            post={postContent}
            channels={channels}
          />}
  </Modal>;

export default EditPostModal;
