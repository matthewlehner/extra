// @flow
import React from "react";
import { graphql } from "react-apollo";

import archivePostMutation from "../../app/queries/archive-post-content-mutation.gql";
import collectionPageQuery from "../../app/queries/collection-page.gql";

import Post from "../post";
import PostChannelsFooter from "./channels-footer";

const CollectionPost = ({
  id,
  body,
  channels,
  handleArchive,
  collectionPath
}) =>
  <Post>
    <p>
      {body}
    </p>
    <PostChannelsFooter
      channels={channels}
      id={id}
      onArchive={handleArchive}
      collectionPath={collectionPath}
    />
  </Post>;

export default graphql(archivePostMutation, {
  props: ({ mutate }) => ({ handleArchive: mutate }),
  options: ({ id }) => ({
    variables: { id },
    update: (
      proxy,
      {
        data: {
          archivePostContent: { id: postId, collection: { id: collectionId } }
        }
      }
    ) => {
      const query = {
        query: collectionPageQuery,
        variables: { id: collectionId }
      };
      const data = proxy.readQuery(query);
      data.collection.posts = data.collection.posts.filter(
        ({ id }) => id !== postId
      );
      proxy.writeQuery({ ...query, data });
    }
  })
})(CollectionPost);
