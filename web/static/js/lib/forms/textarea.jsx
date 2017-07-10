// @flow
import React, { Component } from "react";
import { handleChange } from "./utils";

class Textarea extends Component {
  props: {
    onChange: (string, string) => void,
    name: string,
    value: string
  };

  textarea: HTMLInputElement;

  static defaultProps = {
    className: "form__control form_textarea"
  };

  onTextareaChange = (event: SyntheticInputEvent) => {
    const { name, onChange } = this.props;
    handleChange(event, name, onChange);
    this.adjustTextarea(event.target);
  };

  adjustTextarea(target: EventTarget = this.textarea) {
    if (target instanceof HTMLTextAreaElement) {
      // eslint-disable-next-line no-param-reassign
      target.style.height = "";
      if (target.scrollHeight > target.clientHeight) {
        // eslint-disable-next-line no-param-reassign
        target.style.height = `${target.scrollHeight}px`;
      }
    }
  }

  render() {
    const { name, value, onChange, ...props } = this.props;

    return (
      <textarea
        {...props}
        ref={input => {
          this.textarea = input;
        }}
        id={name}
        name={name}
        value={value}
        rows="3"
        onChange={this.onTextareaChange}
      />
    );
  }
}

export default Textarea;
