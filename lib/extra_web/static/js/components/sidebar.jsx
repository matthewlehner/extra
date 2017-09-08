// @flow

import React from "react";
import { Link, NavLink } from "react-router-dom";
import Icon from "./icon";
import LogoutLink from "./logout-link";
import LoadingSidebar from "../app/components/loading-sidebar";

type Props = {
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

export default function Sidebar({
  data: { loading, error, channels, collections }
}: Props) {
  if (error) {
    return (
      <div>
        {error.message}
      </div>
    );
  }

  return (
    <section className="sidebar">
      <Icon className="extra-logo" name="logo" />
      {loading
        ? <LoadingSidebar />
        : <nav className="site-nav">
            <section>
              <h3>Collections</h3>
              <ul>
                {collections.map(({ id, name }) =>
                  <li key={`collection-${id}`}>
                    <NavLink to={`/collections/${id}`}>
                      <Icon name="collection" />
                      {name}
                    </NavLink>
                  </li>
                )}
                <li>
                  <NavLink to="/new-collection">
                    <Icon name="addNew" />
                    Add new
                  </NavLink>
                </li>
              </ul>
            </section>

            <section>
              <h3>Channels</h3>
              <ul>
                {channels.map(({ id, name, provider }) =>
                  <li key={`channel-${id}`}>
                    <NavLink to={`/channels/${id}`}>
                      <Icon name={`${provider}Badge`} />
                      {name}
                    </NavLink>
                  </li>
                )}
                <li>
                  <NavLink to="/new-channel">
                    <Icon name="addNew" />
                    Add new
                  </NavLink>
                </li>
              </ul>
            </section>

            <section>
              <h3>General</h3>
              <ul>
                <li>
                  <NavLink to="/account">
                    <Icon name="account" />
                    Account
                  </NavLink>
                </li>
                <li>
                  <LogoutLink>
                    <Icon name="logout" />
                    Logout
                  </LogoutLink>
                </li>
              </ul>
            </section>
          </nav>}

      <div className="gradient-container">
        <div className="gradient" />
      </div>
    </section>
  );
}
