// @flow
import React from "react";

import CollectionPost from "./post/collection-post";
import PostList from "./post/list";

type Props = {
  posts: Array<{
    id: string,
    body: string,
    channels: Array<Extra$Channel>
  }>,
  collectionPath: string
};

const CollectionPosts = ({ posts, collectionPath }: Props) =>
  <section className="posts-collection">
    <header>
      <h2>Posts</h2>
    </header>
    <PostList>
      {posts.map(({ id, body, channels }) =>
        <CollectionPost
          key={id}
          id={id}
          body={body}
          channels={channels}
          collectionPath={collectionPath}
        />
      )}
    </PostList>
  </section>;

export default CollectionPosts;
