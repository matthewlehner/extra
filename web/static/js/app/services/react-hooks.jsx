import React from "react";
import { render } from "react-dom";
import { ApolloClient, ApolloProvider } from "react-apollo";

import { BrowserRouter as Router, Route } from "react-router-dom";
import { AsyncChannelPage } from "../../components/async-component";
import Sidebar from "../pages/sidebar";

const client = new ApolloClient();

const App = () => (
  <Router basename="/app">
    <div style={{ display: "flex" }}>
      <Sidebar />
      <main role="main">
        <Route path="/channels/:id" component={AsyncChannelPage} />
      </main>
    </div>
  </Router>
);

const rootEl = document.getElementById("react-root");

render(
  <ApolloProvider client={client}>
    <App />
  </ApolloProvider>,
  rootEl
);
