import React, { Component, PropTypes } from "react";
import { graphql } from "react-apollo";

import Schedule from "components/schedule";
import currentChannelForLayoutQuery from "app/queries/channel-page.gql";
import updateScheduleMutation from "app/queries/update-schedule.gql";

class ChannelPage extends Component {
  static propTypes = {
    data: PropTypes.shape({
      loading: PropTypes.bool.isRequired,
      error: PropTypes.shape({
        message: PropTypes.string.isRequired
      }),
      channel: PropTypes.shape({
        id: PropTypes.string.isRequired,
        name: PropTypes.string.isRequired,
        image: PropTypes.string.isRequired,
        provider: PropTypes.string.isRequired
      }),
      schedule: PropTypes.shape({
        autopilot: PropTypes.bool.isRequired
      })
    }).isRequired,
    updateSchedule: PropTypes.func.isRequired
  }

  render() {
    const { updateSchedule, data: { error, schedule, channel, loading } } = this.props;
    const toggleAutopilot = () => (
      updateSchedule({ variables: { channelId: channel.id, autopilot: !schedule.autopilot } })
    );
    const scheduleProps = { toggleAutopilot, ...schedule };

    if (loading) {
      return <div>Loading!</div>;
    }

    if (error && error.message) {
      return <div>{error.message}</div>;
    }

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

export default graphql(currentChannelForLayoutQuery, {
  options: ({ match }) => ({ variables: { id: match.params.id } })
})(graphql(updateScheduleMutation, { name: "updateSchedule" })(ChannelPage));
