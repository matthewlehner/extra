// @flow

import React, { Component } from "react";
import type { Children } from "react";

export default class Form extends Component {
  props: {
    onSubmit: Function,
    children: Children
  }

  defaultProps = {
    children: null
  };

  handleSubmit = (event: SyntheticEvent): void => {
    event.preventDefault();
    this.props.onSubmit();
  }

  render() {
    const { children, ...props } = this.props;

    return (
      <form {...props} onSubmit={this.handleSubmit}>
        {children}
      </form>
    );
  }
}
