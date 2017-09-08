// @flow
import React from "react";
import { Route } from "react-router-dom";
import { TransitionGroup } from "react-transition-group";

import AnimatedRoute from "./components/animated-route";

import NotificationCenter from "./notifications";
import ChannelPage from "./pages/channel";
import Account from "./pages/account";
import NewPostContent from "./pages/new-post-content";
import ChannelNewPage from "./pages/channel-new";
import CollectionPage from "./pages/collection";
import CollectionNewPage from "./pages/collection-new";
import EditCollectionPage from "./pages/edit-collection-page";
import EditPostContent from "./pages/edit-post-content";

import Sidebar from "./pages/sidebar";

const App = () =>
  <div style={{ display: "flex" }}>
    <Sidebar />
    <TransitionGroup component="main" role="main">
      <AnimatedRoute path="/new-channel" component={ChannelNewPage} />
      <AnimatedRoute path="/channels/:id" component={ChannelPage} />

      <AnimatedRoute path="/new-collection" component={CollectionNewPage} />
      <AnimatedRoute path="/collections/:id" component={CollectionPage} />
      <AnimatedRoute
        path="/collection-settings/:id"
        component={EditCollectionPage}
      />
      <AnimatedRoute
        path="/collections/:collectionId/edit-post/:postId"
        component={EditPostContent}
      />
      <AnimatedRoute path="/account" component={Account} />
    </TransitionGroup>

    <Route path="/collections/:id/new" component={NewPostContent} />
    <NotificationCenter />
  </div>;

export default App;
