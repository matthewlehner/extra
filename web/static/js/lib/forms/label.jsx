// @flow

import React from "react";
import type { Children } from "react";

import Styles from "./form.scss";

const Label = ({
  children,
  htmlFor
}: {
  children: Children,
  htmlFor: string
}) =>
  <label className={Styles.label} htmlFor={htmlFor}>
    {children}
  </label>;

export default Label;
