// @flow

import React from "react";
import { Link } from "react-router-dom";

type ShowCollectionProps = {
  data: {
    loading: boolean,
    error:? {
      message: string
    },
    collection:? {
      id: string,
      name: string
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

      <section className="posts-collection">
        <header>
          <h2>Posts</h2>
        </header>
        <ul className="posts-list" />
      </section>
    </div>
  );
}
