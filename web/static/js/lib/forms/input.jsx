// @flow

import React from "react";
import { handleChange } from "./utils";

type Props = {
  name: string,
  value: string,
  required: Boolean,
  onChange: (string, string) => void,
  type?: string,
  placeholder?: string
};

const Input = ({
  name,
  type,
  placeholder,
  value,
  required,
  onChange
}: Props) => (
  <input
    name={name}
    type={type}
    onChange={e => handleChange(e, name, onChange)}
    value={value}
    placeholder={placeholder}
    required={required}
  />
);

Input.defaultProps = {
  type: "text",
  placeholder: null
};

export default Input;
