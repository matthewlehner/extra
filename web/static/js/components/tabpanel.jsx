import React, { PropTypes } from "react";

const Tabpanel = ({ id, tabId, active, content }) => (
  <div
    className="tabpanel" role="tabpanel" id={id}
    aria-labelledby={tabId} aria-hidden={!active}
  >
    {content}
  </div>
);

Tabpanel.propTypes = {
  id: PropTypes.string.isRequired,
  tabId: PropTypes.string.isRequired,
  active: PropTypes.bool.isRequired,
  content: PropTypes.node.isRequired
};

export default Tabpanel;
