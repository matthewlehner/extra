// @flow

import React from "react";
import type { Children } from "react";

import Styles from "./form.scss";

const Label = (
  { content, htmlFor }: { content: Children, htmlFor: string }
) => (
  <label className={Styles.label} htmlFor={htmlFor}>
    {content}
  </label>
);

export default Label;

