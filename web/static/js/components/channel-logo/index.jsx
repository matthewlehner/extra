// @flow

import React from "react";

import Icons from "app/icons";
import Styles from "./channel-logo.scss";

const ChannelLogo = ({ provider }: { provider: string }) => (
  <svg className={Styles.logo}>
    <use xlinkHref={`#${Icons[provider].id}`} />
  </svg>
);

export default ChannelLogo;
