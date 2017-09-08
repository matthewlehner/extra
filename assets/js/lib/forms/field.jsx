// @flow

import React from "react";
import type { Children } from "react";
import Label from "./label";

type Props = {
  label: string,
  children: Children,
  className?: string
};

const Field = ({ label, children, className }: Props) =>
  <div className={className}>
    <Label htmlFor={label}>
      {label}
    </Label>
    {children}
  </div>;

Field.defaultProps = {
  children: null,
  className: "form__control-group"
};

export default Field;
