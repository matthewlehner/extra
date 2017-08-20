// @flow
import React from "react";
import { Link } from "react-router-dom";
import CollectionPosts from "./collection-posts";
import Icon from "./icon.jsx";

import type { CollectionPageProps } from "../app/pages/collection";

export default function ShowCollection({
  location: { pathname },
  match: { params },
  data: { collection }
}: CollectionPageProps) {
  return (
    <div>
      <header className="heading">
        <h1 className="heading__body">
          {collection.name}
        </h1>
        <Link to={`/collection-settings/${params.id}`}>
          <Icon name="settingsGear" />
          Settings
        </Link>
        <Link className="button button_small" to={`${pathname}/new`}>
          Add Content
        </Link>
      </header>

      <CollectionPosts collectionPath={pathname} posts={collection.posts} />
    </div>
  );
}
