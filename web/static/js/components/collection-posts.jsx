// @flow
import React from "react";
import Post from "./post";
import PostList from "./post/list";
import PostChannelsFooter from "./post/channels-footer";

type Props = {
  posts: Array<{
    id: string,
    body: string,
    channels: Array<Extra$Channel>
  }>
};

const CollectionPosts = ({ posts }: Props) =>
  <section className="posts-collection">
    <header>
      <h2>Posts</h2>
    </header>
    <PostList>
      {posts.map(({ id, body, channels }) =>
        <Post key={id}>
          <p>
            {body}
          </p>
          <PostChannelsFooter channels={channels} id={id} />
        </Post>
      )}
    </PostList>
  </section>;

export default CollectionPosts;
