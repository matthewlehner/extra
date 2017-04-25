// @flow

import React from "react";
import type { Match, RouterHistory } from "react-router-dom";

import Modal from "./modal";
import PostContentForm from "./forms/post-content";

type Props = {
  match: Match,
  history: RouterHistory,
  data: {
    loading: boolean,
    error?: {
      message: string
    },
    channels: Array<{ id: string, provider: string, name: string }>,
    collections: Array<{ id: string, name: string }>
  },
  addPostContent: ({
    variables: {
      body: string, collectionId: string, channelIds: Array<string>
    }
  }) => void
};

const NewPostContent = (
  {
    history,
    addPostContent,
    match: { params },
    data: { loading, error, channels, collections }
  }: Props
) => {
  const cancelPath = `/collections/${params.id}`;
  const onCancel = () => history.push(cancelPath);

  const postContentFormProps = {
    cancelPath, channels, collections, addPostContent
  };

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
