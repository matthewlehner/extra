// @flow

import React from "react";
import { Link, NavLink } from "react-router-dom";
import Icon from "./icon";

type SidebarProps = {
  data: {
    loading: boolean,
    error?: {
      message: string
    },
    channels: Array<{
      id: string,
      provider: string,
      name: string
    }>,
    collections: Array<{
      id: string,
      name: string
    }>
  }
};

export default function Sidebar(
  { data: { loading, error, channels, collections } }: SidebarProps
) {
  if (error) { return <div>{error.message}</div>; }

  return (
    <section className="sidebar">
      <Icon className="extra-logo" name="logo" />
      <nav className="site-nav">
        <section>
          <h3>Collections</h3>
          <ul>
            {
              loading
                ? null
                : collections.map(({ id, name }) => (
                  <li key={`collection-${id}`}>
                    <NavLink to={`/collections/${id}`}>
                      <Icon name="collection" />
                      {name}
                    </NavLink>
                  </li>
                ))
            }
            <li>
              <Link to="/">
                <Icon name="addNew" />
                Add new
              </Link>
            </li>
          </ul>
        </section>

        <section>
          <h3>Channels</h3>
          <ul>
            {
              loading
                ? null
                : channels.map(({ id, name, provider }) => (
                  <li key={`channel-${id}`}>
                    <NavLink to={`/channels/${id}`}>
                      <Icon name={`${provider}Badge`} />
                      {name}
                    </NavLink>
                  </li>
                ))
            }
            <li>
              <Link to="/">
                <Icon name="addNew" />
                Add new
              </Link>
            </li>
          </ul>
        </section>

        <section>
          <h3>General</h3>
          <ul>
            <li>
              <Link to="/">
                <Icon name="performance" />
                Performance
              </Link>
            </li>
            <li>
              <Link to="/account">
                <Icon name="account" />
                Account
              </Link>
            </li>
            <li>
              <Link to="/">
                <Icon name="logout" />
                Logout
              </Link>
            </li>
          </ul>
        </section>
      </nav>

      <div className="gradient-container">
        <div className="gradient" />
      </div>
    </section>
  );
}
