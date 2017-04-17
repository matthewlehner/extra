// @flow

import React from "react";
import type { Children } from "react";

type SelectProps = {
  value?: string | number,
  onChange: Function,
  children?: Children
};

const Select = ({ value, onChange, children } :SelectProps) => (
  <div className="select">
    <select value={value} onChange={onChange}>
      {children}
    </select>
  </div>
);

Select.defaultProps = {
  value: "",
  children: null
};

export default Select;
