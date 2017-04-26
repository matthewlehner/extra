// @flow

import React from "react";
import { linkButton } from "./link-button.scss";

type Props = {};

const LinkButton = (props:Props) => (
  <button {...props} className={linkButton} />
);

export default LinkButton;
