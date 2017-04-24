// @flow

import React from "react";
import type { Match, RouterHistory } from "react-router-dom";

import Modal from "./modal";
import PostContentForm from "./forms/post-content";

type NewPostContentProps = {
  match: Match,
  history: RouterHistory,
  data: {
    loading: boolean,
    error?: {
      message: string
    },
    channels: Array<{ id: string, provider: string, name: string }>,
    collections: Array<{ id: string, name: string }>
  }
};

const NewPostContent = (
  {
    match: { params }, history, data: { loading, error, channels, collections }
  }: NewPostContentProps
) => {
  const cancelPath = `/collections/${params.id}`;
  const onCancel = () => history.push(cancelPath);

  const postContentFormProps = { cancelPath, channels, collections };

  return (
    <Modal title="Create new post" onDismiss={onCancel} cancelPath={cancelPath}>
      {
        loading || error
          ? "Loading"
          : <PostContentForm {...postContentFormProps} />
      }
    </Modal>
  );
};

export default NewPostContent;
