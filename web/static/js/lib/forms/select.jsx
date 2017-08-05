// @flow
import React from "react";

type Props = {
  placeholder?: string,
  value?: string,
  name: string,
  options: Array<{ value: string, label: string }>
};

const Select = ({ name, options, placeholder, ...props }: Props) =>
  <div className="select">
    <select className="form__control" name={name} id={name} {...props}>
      {placeholder && !props.value
        ? <option key="placeholder" value="">
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
  value: ""
};

export default Select;
