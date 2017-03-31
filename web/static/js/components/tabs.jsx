import React, { Component, PropTypes } from "react";
import { withRouter } from "react-router-dom";
import { parse } from "query-string";

import Tab from "./tab";
import Tabpanel from "./tabpanel";

class Tabs extends Component {
  static propTypes = {
    name: PropTypes.string.isRequired,
    location: PropTypes.shape({
      search: PropTypes.string.isRequired
    }).isRequired,
    panels: PropTypes.arrayOf(
      PropTypes.shape({
        label: PropTypes.string.isRequired,
        content: PropTypes.node.isRequired
      })
    ).isRequired,
    children: PropTypes.node
  }

  static defaultProps = { children: null }

  render() {
    const { panels, location, name, children } = this.props;

    const { tabs, tabPanels } = panels.reduce(
      (accumulator, { label, content }, index) => {
        const panelId = label.toLowerCase();
        const tabId = `${panelId}-tab`;
        const activePanel = parse(location.search)[name];
        const active = activePanel ? activePanel === panelId : index === 0;

        accumulator.tabs.push(
          <Tab
            label={label} panelId={panelId} key={tabId} location={location}
            active={active}
          />
        );

        accumulator.tabPanels.push(
          <Tabpanel
            content={content} key={panelId} tabId={tabId} id={panelId} active={active}
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
        {children}
      </div>
    );
  }
}

export default withRouter(Tabs);
