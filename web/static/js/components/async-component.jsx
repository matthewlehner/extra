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

export function ExtraLoadable(opts: any) {
  return Loadable(
    Object.assign(
      {
        loading: LoadingPage,
        render(loaded, props) {
          let Component;

          if (props.data && props.data.loading) {
            Component = LoadingPage;
          } else {
            Component = loaded.default;
          }

          return <Component {...props} />;
        }
      },
      opts
    )
  );
}

export function PageLoader(loader: any) {
  const Loadable = ExtraLoadable({ loader });

  return (props: any) => {
    return (
      <div className="app-panel">
        <Loadable {...props} />
      </div>
    );
  };
}
