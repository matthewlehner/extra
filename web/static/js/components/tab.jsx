import React, { PropTypes } from "react";

const Tab = ({ panelId, label, tabId, selected, onSelect }) => (
  <a
    className="tab" role="tab" href={`#${panelId}`}
    id={tabId} aria-controls={panelId} onClick={onSelect}
    data-title={label} aria-selected={selected}
  >
    {label}
  </a>
);

Tab.propTypes = {
  label: PropTypes.string.isRequired,
  panelId: PropTypes.string.isRequired,
  tabId: PropTypes.string.isRequired,
  selected: PropTypes.bool.isRequired,
  onSelect: PropTypes.func.isRequired
};

export default Tab;
