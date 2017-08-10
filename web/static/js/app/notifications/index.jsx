// @flow
import React, { Component } from "react";
import { subscribe, getState } from "./store";

export default class Notifications extends Component {
  constructor(props) {
    super(props);

    const messages = getState();
    this.state = { messages };
    subscribe(this.onUpdateMessages);
  }

  onUpdateMessages = messages => {
    this.setState(() => ({ messages }));
  };

  render() {
    return (
      <div className="flash_container">
        <div className="flash_message flash_message__info">
          I'm an info message!
        </div>
        <div className="flash_message flash_message__error">
          I'm an error message!
        </div>
      </div>
    );
  }
}
