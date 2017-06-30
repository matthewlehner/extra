// @flow
import React from "react";
import Icons from "app/icons";

type Props = {
  className?: string,
  name: string,
  width?: string,
  height?: string
};

const Icon = ({ className, name, width, height }: Props) =>
  <svg className={className} width={width} height={height}>
    <use xlinkHref={`#${Icons[name].id}`} />
  </svg>;

Icon.defaultProps = {
  className: "icon",
  width: null,
  height: null
};

export default Icon;
