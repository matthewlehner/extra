// @flow

import React from "react";
import { render } from "react-dom";
import { ApolloClient, ApolloProvider, createNetworkInterface } from "react-apollo";

import { BrowserRouter as Router, Route } from "react-router-dom";
import { AsyncChannelPage } from "../../components/async-component";
import Sidebar from "../pages/sidebar";

const csrfMetaEl = document.querySelector("meta[name='csrf-token'");
let csrfToken:string;

if (csrfMetaEl && csrfMetaEl instanceof HTMLMetaElement) {
  csrfToken = csrfMetaEl.content;
}
else {
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
          <Route path="/channels/:id" component={AsyncChannelPage} />
        </main>
      </div>
    </Router>
  </ApolloProvider>
);

const rootEl = document.getElementById("react-root");

render(
  <App />,
  rootEl
);
