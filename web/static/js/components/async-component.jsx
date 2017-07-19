// @flow
import React from "react";
import Loadable from "react-loadable";
import LoadingPage from "../app/components/loading-page";

export const LoadingComponent = () => <div>Loading</div>;

export default function asyncComponent(loadingComponent: () => Promise<*>) {
  return Loadable({
    loader: loadingComponent,
    loading: LoadingComponent
  });
}

export function ExtraLoadable(opts) {
  return Loadable(
    Object.assign(
      {
        loading: LoadingPage
      },
      opts
    )
  );
}

export const AsyncCollectionPage = ExtraLoadable({
  loader: () => import(
    /* webpackChunkName: "collection-page" */ "../app/pages/collection"
  )
});
