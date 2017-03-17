import React, { Component, PropTypes } from "react";
import { gql, graphql } from "react-apollo";

import Schedule from "components/schedule";

class ChannelPage extends Component {
  static propTypes = {
    data: PropTypes.shape({
      loading: PropTypes.bool.isRequired,
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

  toggleAutopilot = () => this.setState(prevState => (
    { schedule: { autoPilot: !prevState.schedule.autoPilot } }
  ));

  render() {
    const { updateSchedule, data: { schedule, channel, loading } } = this.props;
    const toggleAutopilot = () => (
      updateSchedule({ variables: { channelId: channel.id, autopilot: !schedule.autopilot } })
    );
    const scheduleProps = { toggleAutopilot, ...schedule };

    if (loading) {
      return <div>Loading!</div>;
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

const CurrentChannelForLayout = gql`
  query ChannelPage($id: ID!) {
    channel(id: $id) {
      id,
      name,
      image,
      provider
    }
    schedule(channelId: $id) {
      id,
      autopilot
    }
  }
`;

const updateSchedule = gql`
  mutation UpdateSchedule($channelId: ID!, $autopilot: Boolean) {
    updateSchedule(
      channelId: $channelId, schedule: { autopilot: $autopilot }
    ) {
      id,
      autopilot
    }
  }
`;

export default graphql(CurrentChannelForLayout, {
  options: ({ match }) => ({ variables: { id: match.params.id } })
})(graphql(updateSchedule, { name: "updateSchedule" })(ChannelPage));
