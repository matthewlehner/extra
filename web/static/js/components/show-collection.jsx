// @flow

import React from "react";
import { Link } from "react-router-dom";
import type { Location } from "react-router-dom";
import CollectionPosts from "./collection-posts";

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
        body: string,
        channels: Array<Extra$Channel>
      }>
    }
  },
  location: Location
};

export default function ShowCollection(
  { location, data: { loading, error, collection } }: ShowCollectionProps
) {
  if (error) { return <div>{error.message}</div>; }
  if (loading || !collection) { return <div>Loading</div>; }

  return (
    <div>
      <header className="heading">
        <h1 className="heading__body">{collection.name}</h1>
        <Link className="button button_small" to={`${location.pathname}/new`}>
          Create new post
        </Link>
      </header>

      <CollectionPosts posts={collection.posts} />
    </div>
  );
}
