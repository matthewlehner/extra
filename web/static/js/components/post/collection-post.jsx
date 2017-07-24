// @flow
import React from "react";

import Post from "../post";
import PostChannelsFooter from "./channels-footer";

const CollectionPost = ({ id, body, channels }) =>
  <Post>
    <p>
      {body}
    </p>
    <PostChannelsFooter channels={channels} id={id} />
  </Post>;

export default CollectionPost;
