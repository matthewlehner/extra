// @flow
import React from "react";
import { Route, Switch } from "react-router-dom";

import { CSSTransition } from "react-transition-group";

function AnimatedRoute({ path, component: Component, ...rest }) {
  return (
    <Route
      path={path}
      children={props => {
        if (!props.match) {
          return null;
        }

        return (
          <CSSTransition
            {...rest}
            key={props.match.url}
            classNames="app-panel"
            timeout={{ enter: 300, exit: 150 }}
          >
            <Switch>
              <Component {...props} />
            </Switch>
          </CSSTransition>
        );
      }}
    />
  );
}

export default AnimatedRoute;
