import React from "react";
import { render } from "react-dom";

import { BrowserRouter as Router, Route } from "react-router-dom";
import ChannelPage from "../pages/channel";

const App = () => (
  <Router basename="/app">
    <Route path="/channels/:id" component={ChannelPage} />
  </Router>
);

const rootEl = document.getElementById("react-root");

render(<App />, rootEl);

// render(<Modal/>, rootEl);
