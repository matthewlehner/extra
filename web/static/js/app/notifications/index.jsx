// @flow
import React, { PureComponent } from "react";
import { TransitionGroup } from "react-transition-group";
import { subscribe, getState } from "./store";
import type { Notifications } from "./store";

import FlashMessage from "./message";

export default class NotificationCenter extends PureComponent {
  props: {};
  state: {
    messages: Notifications
  };
  constructor(props: {}) {
    super(props);

    const messages = getState();
    this.state = { messages };
    subscribe(this.onUpdateMessages);
  }

  onUpdateMessages = (messages: Notifications): void => {
    this.setState(() => ({ messages }));
  };

  render() {
    const { messages } = this.state;

    const flashes = messages.map(FlashMessage);

    return (
      <TransitionGroup className="flash_container">
        {flashes}
      </TransitionGroup>
    );
  }
}
