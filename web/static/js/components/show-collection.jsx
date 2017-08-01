// @flow

import React from "react";
import { Link } from "react-router-dom";
import CollectionPosts from "./collection-posts";
import Icon from "./icon.jsx";

import type { CollectionPageProps } from "../app/pages/collection";

export default function ShowCollection({
  location,
  data: { loading, error, collection }
}: CollectionPageProps) {
  if (error) {
    return (
      <div>
        {error.message}
      </div>
    );
  }
  if (loading) {
    return <div>Loading</div>;
  }

  return (
    <div>
      <header className="heading">
        <h1 className="heading__body">
          {collection.name}
        </h1>
        <Link to={`${location.pathname}/settings`}>
          <Icon name="settingsGear" />
          Settings
        </Link>
        <Link className="button button_small" to={`${location.pathname}/new`}>
          Create new post
        </Link>
      </header>

      <CollectionPosts
        collectionPath={location.pathname}
        posts={collection.posts}
      />
    </div>
  );
}
