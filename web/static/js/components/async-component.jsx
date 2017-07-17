// @flow
import React from "react";
import Loadable from "react-loadable";

export const LoadingComponent = () => <div>Loading</div>;

export default function asyncComponent(loadingComponent) {
  return Loadable({
    loader: loadingComponent,
    loading: LoadingComponent
  });
}

export const AsyncChannelPage = asyncComponent(() =>
  import("../app/pages/channel").then(module => module.default)
);

export const AsyncCollectionPage = asyncComponent(() =>
  import("../app/pages/collection").then(module => module.default)
);
