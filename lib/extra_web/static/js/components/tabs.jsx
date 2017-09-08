// @flow

import React, { Component } from "react";
import { withRouter } from "react-router-dom";
import { parse } from "query-string";
import type { Children } from "react";
import type { Location } from "react-router-dom";

import Tab from "./tab";
import Tabpanel from "./tabpanel";

import type DailySchedule from "./daily-schedule";

class Tabs extends Component {
  props: {
    name: string,
    location: Location,
    panels: Array<{ label: string, content: React.Element<DailySchedule> }>,
    children: Children
  };

  render() {
    const { panels, location, name, children } = this.props;

    const {
      tabs,
      tabPanels
    }: { tabs: Array<Tab>, tabPanels: Array<Tabpanel> } = panels.reduce(
      (accumulator, { label, content }, index) => {
        const panelId = label.toLowerCase();
        const tabId = `${panelId}-tab`;
        const activePanel = parse(location.search)[name];
        const active = activePanel ? activePanel === panelId : index === 0;

        accumulator.tabs.push(
          <Tab
            label={label}
            panelId={panelId}
            key={tabId}
            location={location}
            active={active}
          />
        );

        accumulator.tabPanels.push(
          <Tabpanel key={panelId} tabId={tabId} id={panelId} active={active}>
            {content}
          </Tabpanel>
        );
        return accumulator;
      },
      { tabs: [], tabPanels: [] }
    );

    return (
      <div className="tab-container">
        {/*  eslint-disable jsx-a11y/no-noninteractive-element-to-interactive-role */}
        <nav role="tablist" className="tablist">
          {tabs}
        </nav>
        {tabPanels}
        <div className="tab-footer">
          {children}
        </div>
      </div>
    );
  }
}

export default withRouter(Tabs);
