// @flow

import React from "react";

export default function Icon({ className, name }:{ className?: string, name:string }) {
  return <svg className={className}><use xlinkHref={`/images/app.svg#${name}-icon`} /></svg>;
}

Icon.defaultProps = {
  className: "icon"
};
