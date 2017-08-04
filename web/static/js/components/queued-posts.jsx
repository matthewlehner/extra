// @flow

import React from "react";
import { graphql } from "react-apollo";
import QueuedPostsQuery from "app/queries/queued-posts-for-channel.gql";
import QueuedPost from "./post/queued";
import PostList from "./post/list";

type Props = {
  data: {
    loading: Boolean,
    queuedPosts: Array<Extra$QueuedPost>
  }
};

const QueuedPosts = ({ data: { loading, queuedPosts } }: Props) =>
  <section>
    <header>
      <h2>Scheduled Posts</h2>
    </header>

    <PostList>
      {loading
        ? null
        : queuedPosts.map(post => <QueuedPost key={post.id} {...post} />)}
    </PostList>
  </section>;

export default graphql(QueuedPostsQuery)(QueuedPosts);
