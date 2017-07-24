// @flow
import React from "react";
import { graphql } from "react-apollo";

import archivePostMutation from "../../app/queries/archive-post-content-mutation.gql";

import Post from "../post";
import PostChannelsFooter from "./channels-footer";

const CollectionPost = ({ id, body, channels, handleArchive }) =>
  <Post>
    <p>
      {body}
    </p>
    <PostChannelsFooter channels={channels} id={id} onArchive={handleArchive} />
  </Post>;

export default graphql(archivePostMutation, {
  props: ({ mutate }) => ({
    handleArchive: mutate
  }),
  options: ({ id }) => ({
    variables: { id }
  })
})(CollectionPost);
