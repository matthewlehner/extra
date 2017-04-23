// @flow

import React from "react";
import type { Children } from "react";
import Label from "./label";

const Field = (
  { label, children }: { label: string, children?: Children }
) => (
  <div className="form__control-group">
    <Label content={label} htmlFor={label} />
    {children}
  </div>
);

Field.defaultProps = {
  children: null
};

export default Field;
