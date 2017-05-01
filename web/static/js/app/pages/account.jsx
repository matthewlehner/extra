// @flow

import asyncComponent from "components/async-component";

export default asyncComponent(() =>
  import("../../components/account").then(module => module.default)
);
