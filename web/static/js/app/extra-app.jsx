// @flow
import React from "react";
import { Route, Switch, withRouter } from "react-router-dom";
import { TransitionGroup, CSSTransition } from "react-transition-group";

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

const App = ({ location }) =>
  <div style={{ display: "flex" }}>
    <Sidebar />
    <TransitionGroup component="main" role="main">
      <CSSTransition
        key={location.key}
        location={location}
        classNames="app-panel"
        timeout={{ enter: 300, exit: 150 }}
      >
        <Switch>
          <Route path="/new-channel" component={ChannelNewPage} />
          <Route path="/channels/:id" component={ChannelPage} />

          <Route path="/new-collection" component={CollectionNewPage} />
          <Route path="/collections/:id" component={CollectionPage} />
          <Route
            path="/collection-settings/:id"
            component={EditCollectionPage}
          />

          <Route path="/collections/:id/new" component={NewPostContent} />
          <Route
            path="/collections/:collectionId/edit-post/:postId"
            component={EditPostContent}
          />
          <Route path="/account" component={Account} />
        </Switch>
      </CSSTransition>
    </TransitionGroup>
    <NotificationCenter />
  </div>;

export default withRouter(App);
