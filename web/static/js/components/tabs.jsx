import React, { Component, PropTypes } from "react";

import Tab from "./tab";
import Tabpanel from "./tabpanel";

export default class Tabs extends Component {
  render() {
    const { panels, activePanel } = this.props;

    const { tabs, tabPanels } = panels.reduce(
      (accumulator, { label, content }, index) => {
        const panelId = label.toLowerCase();
        const tabId = `${panelId}-tab`;
        const selected = activePanel ? activePanel === label : index === 0;

        accumulator.tabs.push(
          <Tab
            label={label} panelId={panelId} tabId={tabId} selected={selected}
            key={tabId}
          />
        );

        accumulator.tabPanels.push(
          <Tabpanel
            id={panelId} tabId={tabId} selected={selected} content={content}
            key={panelId}
          />
        );
        return accumulator;
      },
      { tabs: [], tabPanels: [] }
    );

    return (
      <div className="tab-container">
        <nav role="tablist" className="tablist">{tabs}</nav>
        {tabPanels}
      </div>
    );
  }
}

Tabs.propTypes = {
  panels: PropTypes.arrayOf(
    PropTypes.shape({
      label: PropTypes.string.isRequired,
      content: PropTypes.node.isRequired
    })
  ).isRequired,
  activePanel: PropTypes.string
};

Tabs.defaultProps = {
  activePanel: null
};
