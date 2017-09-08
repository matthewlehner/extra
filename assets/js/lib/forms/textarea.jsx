// @flow
import React, { Component } from "react";
type Props = {
    onChange: SyntheticInputEvent<*> => void,
    name: string,
    value: string
  };

class Textarea extends Component<Props, {}> {
  textarea: HTMLInputElement;

  static defaultProps = {
    className: "form__control form_textarea"
  };

  onTextareaChange = (event: SyntheticInputEvent<*>) => {
    this.props.onChange(event);
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
