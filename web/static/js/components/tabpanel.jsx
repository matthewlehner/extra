// @flow

import React from "react";
import type { Children } from "react";

type TabpanelProps = {
  id: string,
  tabId: string,
  active: boolean,
  children?: Children
};

const Tabpanel = ({ id, tabId, active, children }: TabpanelProps) => (
  <div
    className="tabpanel" role="tabpanel" id={id}
    aria-labelledby={tabId} aria-hidden={!active}
  >
    {children}
  </div>
);

Tabpanel.defaultProps = {
  children: null
};

export default Tabpanel;
