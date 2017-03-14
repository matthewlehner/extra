// @flow

import React, { PropTypes } from "react";
import { NavLink } from "react-router-dom";

/* :: type panelId: string, label: string, tabId: string, selected: string, onSelect: () => void */
const Tab = ({ panelId, label, tabId, selected, onSelect }) => (
  <NavLink
    to={`/channels/:id/#${panelId}`}
    className="tab" role="tab"
    id={tabId} aria-controls={panelId} onClick={onSelect}
    data-title={label} aria-selected={selected}
  >
    {label}
  </NavLink>
);

Tab.propTypes = {
  label: PropTypes.string.isRequired,
  panelId: PropTypes.string.isRequired,
  tabId: PropTypes.string.isRequired,
  selected: PropTypes.bool.isRequired,
  onSelect: PropTypes.func.isRequired
};

export default Tab;
