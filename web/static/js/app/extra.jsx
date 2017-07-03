// @flow
import React from "react";
import { render } from "react-dom";

import { ApolloProvider } from "react-apollo";
import { BrowserRouter as Router } from "react-router-dom";
import client from "./apollo-client";

import App from "./extra-app";

const rootEl = document.getElementById("react-root");
render(
  <ApolloProvider client={client}>
    <Router basename="/app">
      <App />
    </Router>
  </ApolloProvider>,
  rootEl
);
