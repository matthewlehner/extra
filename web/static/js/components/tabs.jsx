import React, { Component, PropTypes } from "react";

import Tab from "./tab";
import Tabpanel from "./tabpanel";

export default class Tabs extends Component {
  static propTypes = {
    panels: PropTypes.arrayOf(
      PropTypes.shape({
        label: PropTypes.string.isRequired,
        content: PropTypes.node.isRequired
      })
    ).isRequired
  }

  state = {
    activePanel: null
  }

  selectPanel = (label) => {
    this.setState(prevState => Object.assign(prevState, { activePanel: label }));
  }

  render() {
    const { panels } = this.props;
    const { activePanel } = this.state;

    const { tabs, tabPanels } = panels.reduce(
      (accumulator, { label, content }, index) => {
        const panelId = label.toLowerCase();
        const tabId = `${panelId}-tab`;
        const selected = activePanel ? activePanel === label : index === 0;

        accumulator.tabs.push(
          <Tab
            label={label} panelId={panelId} tabId={tabId} selected={selected}
            key={tabId} onSelect={() => this.selectPanel(label)}
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
  ).isRequired
};
