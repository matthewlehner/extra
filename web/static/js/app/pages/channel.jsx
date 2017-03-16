import React, { Component, PropTypes } from "react";
import { gql, graphql } from "react-apollo";

import Schedule from "components/schedule";

class ChannelPage extends Component {
  static propTypes = {
    data: PropTypes.shape({
      loading: PropTypes.bool.isRequired,
      channel: PropTypes.shape({
        name: PropTypes.string.isRequired,
        image: PropTypes.string.isRequired,
        provider: PropTypes.string.isRequired
      }).isRequired
    }).isRequired

  }

  componentWillMount() {
    const schedule = { autoPilot: true };
    this.setState(() => ({ schedule }));
  }

  toggleAutopilot = () => this.setState(prevState => (
    { schedule: { autoPilot: !prevState.schedule.autoPilot } }
  ));

  render() {
    const { data: { channel, loading } } = this.props;
    const { schedule } = this.state;
    const scheduleProps = {
      toggleAutopilot: this.toggleAutopilot,
      ...schedule
    };

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
      name,
      image,
      provider
    }
  }
`;

export default graphql(CurrentChannelForLayout, {
  options: ({ match }) => ({ variables: { id: match.params.id } })
})(ChannelPage);
