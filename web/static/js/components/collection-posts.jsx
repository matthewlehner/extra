// @flow

import React from "react";
import PostList from "./post/list";

type Props = {
  posts: Array<{
    id: string,
    body: string
  }>
};

const CollectionPosts = ({ posts }: Props) => (
  <section className="posts-collection">
    <header>
      <h2>Posts</h2>
    </header>
    <PostList>
      { posts.map(({ id, body }) => (
        <li key={id} className="post-preview">
          <p>{body}</p>
        </li>
      ))}
    </PostList>
  </section>
);

export default CollectionPosts;
