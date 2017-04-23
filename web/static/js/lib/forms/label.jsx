// @flow

import React from "react";
import type { Children } from "react";

const Label = (
  { content, htmlFor }: { content: Children, htmlFor: string }
) => (
  <label className="form__control-label" htmlFor={htmlFor}>
    {content}
  </label>
);

export default Label;

