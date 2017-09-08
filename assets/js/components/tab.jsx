// @flow

import React from "react";
import { Link } from "react-router-dom";
import { parse, stringify } from "query-string";

import type { Location, LocationShape } from "react-router-dom";

type TabProps = {
  label: string,
  panelId: string,
  location: Location,
  active: boolean
};

const Tab = ({ label, panelId, location, active }: TabProps) => {
  const searchParams = Object.assign(
    {},
    parse(location.search),
    { schedule: panelId }
  );
  const search:string = stringify(searchParams);
  const to:LocationShape = Object.assign({}, location, { search });

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

export default Tab;
