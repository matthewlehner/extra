import React, { Component } from "react";

import Schedule from "components/schedule";

export default class ChannelPage extends Component {
  componentWillMount() {
    const channel = window.pageContext;
    const schedule = { autoPilot: true };
    this.setState(() => ({ channel, schedule }));
  }

  toggleAutopilot = () => this.setState(prevState => (
    { schedule: { autoPilot: !prevState.schedule.autoPilot } }
  ));

  render() {
    const { channel, schedule } = this.state;
    const scheduleProps = {
      toggleAutopilot: this.toggleAutopilot,
      ...schedule
    };

    return (
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

        <Schedule {...scheduleProps} />
      </div>
    );
  }
}
