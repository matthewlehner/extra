import React from "react";

import ToggleSwitch from "components/forms/toggle-switch";

const channel = window.pageContext;

const ChannelPage = () => (
  <div>
    <header className="heading">
      <div className="heading__body">
        <figure className="heading__figure">
          <img src={channel.image} alt="Profile" />
        </figure>
        <h1>{channel.name}</h1>
        <p>{channel.provider} account</p>
      </div>
      <div className="button button_small">
        Delete account
      </div>
    </header>

    <section className="channel-stats">
      <h2>Stats</h2>
      <p>Here are some stats about the channel.</p>
    </section>

    <section className="channel-schedule">
      <h2>Schedule</h2>

      <p>
        <ToggleSwitch checked />
        <strong>Schedule autopilot.</strong> Great for beginners and those with
        massive collections.
      </p>
    </section>
  </div>
);

export default ChannelPage;
