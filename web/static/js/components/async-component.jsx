// @flow

import React from "react";

export default function asyncComponent(getComponent: any) {
  return class AsyncComponent extends React.Component {
    static Component = null;
    state = { Component: AsyncComponent.Component };

    componentWillMount() {
      if (!this.state.Component) {
        getComponent().then((Component) => {
          AsyncComponent.Component = Component;
          this.setState({ Component });
        });
      }
    }
    render() {
      const { Component } = this.state;
      if (Component) {
        return <Component {...this.props} />;
      }
      return null;
    }
  };
}

export const AsyncChannelPage = asyncComponent(() =>
  import("../app/pages/channel").then(module => module.default)
);

export const AsyncCollectionPage = asyncComponent(() =>
  import("../app/pages/collection").then(module => module.default)
);
