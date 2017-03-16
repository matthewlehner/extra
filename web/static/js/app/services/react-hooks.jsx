import React from "react";
import { render } from "react-dom";
import { ApolloClient, ApolloProvider } from "react-apollo";

import { BrowserRouter as Router, Route } from "react-router-dom";
import ChannelPage from "../pages/channel";

const client = new ApolloClient();

const App = () => (
  <Router basename="/app">
    <Route path="/channels/:id" component={ChannelPage} />
  </Router>
);

const rootEl = document.getElementById("react-root");

render(
  <ApolloProvider client={client}>
    <App />
  </ApolloProvider>,
  rootEl
);

// render(<Modal/>, rootEl);
