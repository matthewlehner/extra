// @flow

import React from "react";

type PostListProps = {
  posts: Array<{
    id: string,
    body: string
  }>
};

const PostList = ({ posts }: PostListProps) => (
  <section className="posts-collection">
    <header>
      <h2>Posts</h2>
    </header>
    <ul className="posts-list">
      { posts.map(({ id, body }) => (
        <li key={id} className="post-preview">
          <p>{body}</p>
        </li>
      ))}
    </ul>
  </section>
);

export default PostList;
