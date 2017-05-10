// @flow

import React from "react";
import Icons from "app/icons";

const Icon = ({ className, name }: { className?: string, name: string }) => (
  <svg className={className}>
    <use xlinkHref={`#${Icons[name].id}`} />
  </svg>
);

Icon.defaultProps = {
  className: "icon"
};

export default Icon;
