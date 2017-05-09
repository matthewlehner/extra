// @flow

import React from "react";
import { graphql } from "react-apollo";
import QueuedPostsQuery from "app/queries/queued-posts-for-channel.gql";

import QueuedPost from "./queued-post";

type Props = {
  data: {
    loading: Boolean,
    // error: nil | String,
    queuedPosts: Array<Extra$QueuedPost>
  }
};

const QueuedPosts = (
  { data: { loading, queuedPosts } }: Props
) => (
  <section>
    <h2>Queued Posts</h2>
    <ul className="posts-list">
      { loading ? null :
          queuedPosts.map(post => (<QueuedPost key={post.id} {...post} />))
      }
    </ul>
  </section>
);

export default graphql(QueuedPostsQuery)(QueuedPosts);
