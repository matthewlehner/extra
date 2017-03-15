// @flow

import React, { PropTypes } from "react";
import { Link } from "react-router-dom";
import { parse, stringify } from "query-string";

// :: type label: string, panelId: string, match: string
const Tab = ({ label, panelId, location, active }) => {
  const searchParams = Object.assign(
    {},
    parse(location.search),
    { schedule: panelId }
  );
  const search = stringify(searchParams);
  const to = Object.assign({}, location, { search });

  return (
    <Link
      to={to}
      className="tab"
      data-title={label}
      aria-controls={panelId}
      aria-selected={active}
      id={`${panelId}-tab`}
      role="tab"
    >
      {label}
    </Link>
  );
};

Tab.propTypes = {
  label: PropTypes.string.isRequired,
  panelId: PropTypes.string.isRequired,
  location: PropTypes.shape({
    search: PropTypes.string.isRequired
  }).isRequired,
  active: PropTypes.bool.isRequired
};

export default Tab;
