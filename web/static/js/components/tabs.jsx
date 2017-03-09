import React, { Component, PropTypes } from "react";

import Tab from "./tab";
import Tabpanel from "./tabpanel";

export default class Tabs extends Component {
  render() {
    const { tabContents } = this.props;

    const { tabs, panels } = tabContents.reduce(
      (accumulator, { label, content, selected = false }) => {
        const panelId = label.toLowerCase();
        const tabId = `${panelId}-tab`;

        accumulator.tabs.push(
          <Tab
            label={label} panelId={panelId} tabId={tabId} selected={selected}
            key={tabId}
          />
        );

        accumulator.panels.push(
          <Tabpanel
            id={panelId} tabId={tabId} selected={selected} content={content}
            key={panelId}
          />
        );
        return accumulator;
      },
      { tabs: [], panels: [] }
    );

    return (
      <div className="tab-container">
        <nav role="tablist" className="tablist">{tabs}</nav>
        {panels}
      </div>
    );
  }
}

Tabs.propTypes = {
  tabContents: PropTypes.arrayOf(
    PropTypes.shape({
      label: PropTypes.string.isRequired,
      content: PropTypes.node.isRequired,
      selected: PropTypes.bool
    })
  ).isRequired
};
