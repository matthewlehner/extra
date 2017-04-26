// @flow

import React from "react";
import { linkButton } from "./link-button.scss";

type Props = {
  className?: string
};

const LinkButton = ({ className, ...props }:Props) => (
  <button
    {...props}
    className={className ? `${linkButton} ${className}` : linkButton}
  />
);

LinkButton.defaultProps = {
  className: ""
};

export default LinkButton;
