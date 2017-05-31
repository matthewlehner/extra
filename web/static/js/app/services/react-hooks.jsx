// @flow

import React from "react";
import { render } from "react-dom";
import {
  ApolloClient,
  ApolloProvider,
  createNetworkInterface
} from "react-apollo";

import { BrowserRouter as Router, Route } from "react-router-dom";
import {
  AsyncChannelPage,
  AsyncCollectionPage
} from "components/async-component";
import Account from "app/pages/account";
import NewPostContent from "app/pages/new-post-content";
import ChannelNewPage from "app/pages/channel-new";

import Sidebar from "../pages/sidebar";

const csrfMetaEl: ?HTMLElement = document.querySelector(
  "meta[name='csrf-token']"
);
let csrfToken: string;

if (csrfMetaEl && csrfMetaEl instanceof HTMLMetaElement) {
  csrfToken = csrfMetaEl.content;
} else {
  csrfToken = "";
}

const networkInterface = createNetworkInterface({
  uri: "/graphql",
  opts: {
    credentials: "same-origin",
    headers: {
      "x-csrf-token": csrfToken
    }
  }
});

const client = new ApolloClient({ networkInterface });

const App = () => (
  <ApolloProvider client={client}>
    <Router basename="/app">
      <div style={{ display: "flex" }}>
        <Sidebar />
        <main role="main">
          <Route path="/new-channel" component={ChannelNewPage} />
          <Route path="/channels/:id" component={AsyncChannelPage} />
          <Route path="/collections/:id" component={AsyncCollectionPage} />
          <Route path="/collections/:id/new" component={NewPostContent} />

          <Route path="/account" component={Account} />
        </main>
      </div>
    </Router>
  </ApolloProvider>
);

const rootEl = document.getElementById("react-root");

render(<App />, rootEl);
