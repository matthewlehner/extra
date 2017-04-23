// @flow

import React from "react";
import { handleChange } from "./utils";

const Textarea = (
  { onChange, fieldName, value, ...props }: {
    onChange: (string, string) => void,
    fieldName: string,
    value: string
  }
) => (
  <textarea
    {...props}
    value={value}
    onChange={event => handleChange(event, fieldName, onChange)}
  />
);

Textarea.defaultProps = {
  className: "form__control"
};

export default Textarea;
