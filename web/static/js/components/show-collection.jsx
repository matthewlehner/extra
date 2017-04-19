// @flow

import React from "react";
import { Link } from "react-router-dom";
import PostList from "./post-list";

type ShowCollectionProps = {
  data: {
    loading: boolean,
    error:? {
      message: string
    },
    collection:? {
      id: string,
      name: string,
      posts: Array<{
        id: string,
        body: string
      }>
    }
  }
};

export default function ShowCollection(
  { data: { loading, error, collection } }: ShowCollectionProps
) {
  if (error) { return <div>{error.message}</div>; }
  if (loading || !collection) { return <div>Loading</div>; }

  return (
    <div>
      <header className="heading">
        <h1 className="heading__body">{collection.name}</h1>
        <Link className="button button_small" to="/">
          Create new post
        </Link>
      </header>

      <PostList posts={collection.posts} />
    </div>
  );
}
