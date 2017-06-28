// @flow

import React from "react";
import { handleChange } from "./utils";

type Props = {
  placeholder?: string,
  value?: string,
  name: string,
  options: Array<{ value: string, label: string }>,
  onChange: (field: string, value: string) => void
};

const Select = ({ name, options, onChange, placeholder, ...props }: Props) =>
  <div className="select">
    <select
      className="form__control"
      onChange={event => handleChange(event, name, onChange)}
      name={name}
      id={name}
      {...props}
    >
      {placeholder && !props.value
        ? <option key="placeholder">
            {placeholder}
          </option>
        : null}
      {options.map(({ value, label }) =>
        <option value={value} key={value}>
          {label}
        </option>
      )}
    </select>
  </div>;

Select.defaultProps = {
  placeholder: null,
  value: "",
  onChange: () => {}
};

export default Select;
