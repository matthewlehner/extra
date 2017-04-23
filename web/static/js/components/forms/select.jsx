// @flow

import React from "react";
import type { Children } from "react";

type InputElementAttributes = {
  value?: string | number,
}

type SelectProps = InputElementAttributes & {
  onChange: (Event) => void,
  children?: Children
};

const Select = ({ children, ...props } :SelectProps) => (
  <div className="select">
    <select {...props}>
      {children}
    </select>
  </div>
);

Select.defaultProps = {
  value: "",
  children: null,
  required: false,
  checkValidity: () => {}
};

export default Select;
