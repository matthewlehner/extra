import React, { PropTypes } from "react";

const Tabpanel = ({ id, tabId, selected, content }) => (
  <div
    className="tabpanel" role="tabpanel" id={id}
    aria-labelledby={tabId} aria-hidden={!selected}
  >
    {content}
  </div>
);

Tabpanel.propTypes = {
  id: PropTypes.string.isRequired,
  tabId: PropTypes.string.isRequired,
  selected: PropTypes.bool.isRequired,
  content: PropTypes.node.isRequired
};

export default Tabpanel;
