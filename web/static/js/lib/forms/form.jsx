// @flow

import React, { Component } from "react";
import type { Children } from "react";

export default class Form extends Component {
  props: {
    children: Children
  }

  defaultProps = {
    children: null
  };

  render() {
    const { children, ...props } = this.props;

    return (
      <form {...props}>
        {children}
      </form>
    );
  }
}
