// @flow
import React from "react";
import { Route } from "react-router-dom";

import { AsyncCollectionPage } from "../components/async-component";
import ChannelPage from "./pages/channel";
import Account from "./pages/account";
import NewPostContent from "./pages/new-post-content";
import ChannelNewPage from "./pages/channel-new";
import CollectionNewPage from "./pages/collection-new";
import EditPostContent from "./pages/edit-post-content";

import Sidebar from "./pages/sidebar";

const App = () =>
  <div style={{ display: "flex" }}>
    <Sidebar />
    <main role="main">
      <Route path="/new-channel" component={ChannelNewPage} />
      <Route path="/channels/:id" component={ChannelPage} />

      <Route path="/new-collection" component={CollectionNewPage} />
      <Route path="/collections/:id" component={AsyncCollectionPage} />
      <Route path="/collections/:id/new" component={NewPostContent} />
      <Route
        path="/collections/:collectionId/edit-post/:postId"
        component={EditPostContent}
      />

      <Route path="/account" component={Account} />
    </main>
  </div>;

export default App;
