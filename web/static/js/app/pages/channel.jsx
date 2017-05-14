// @flow

import React from "react";
import { graphql, compose } from "react-apollo";

import Schedule from "components/schedule";
import QueuedPosts from "components/queued-posts";
import currentChannelForLayoutQuery from "app/queries/channel-page.gql";
import updateScheduleMutation from "app/queries/update-schedule.gql";
import addTimeslotMutation from "app/queries/add-timeslot-mutation.gql";

export type CollectionProps = {
  id: string,
  name: string
};

export type RecurrenceProps = {
  enumValues: Array<string>
};

type TimeslotProps = {
  recurrence: string,
  time: string,
  collection: {
    name: string
  }
};

export type ScheduleProps = {
  id: string,
  timeslots: Array<TimeslotProps>,
  autopilot: boolean
};

type Props = {
  updateSchedule: Function,
  addTimeslot: Function,
  data: {
    loading: boolean,
    error?: {
      message: string
    },
    schedule: ScheduleProps,
    channel: {
      id: string,
      image: string,
      name: string,
      provider: string
    },
    collections: Array<CollectionProps>,
    recurrenceType: RecurrenceProps
  }
};

function ChannelPage(props: Props) {
  const {
    updateSchedule,
    addTimeslot,
    data: { loading, error, schedule, channel, collections, recurrenceType }
  } = props;

  if (loading) {
    return <div>Loading!</div>;
  }

  if (error && error.message) {
    return <div>{error.message}</div>;
  }

  const toggleAutopilot = () =>
    updateSchedule({
      variables: { channelId: channel.id, autopilot: !schedule.autopilot }
    });
  const scheduleProps = {
    toggleAutopilot,
    addTimeslot,
    schedule,
    collections,
    recurrenceType
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

      <QueuedPosts channelId={channel.id} />
    </div>
  );
}

export default compose(
  graphql(currentChannelForLayoutQuery, {
    options: ({ match }) => ({ variables: { id: match.params.id } })
  }),
  graphql(updateScheduleMutation, { name: "updateSchedule" }),
  graphql(addTimeslotMutation, {
    name: "addTimeslot",
    options: {
      updateQueries: {
        ChannelPage: (previousData, { mutationResult }) => {
          const newTimeslot = mutationResult.data.addTimeslot;
          return {
            ...previousData,
            schedule: {
              ...previousData.schedule,
              timeslots: [...previousData.schedule.timeslots, newTimeslot]
            }
          };
        }
      },
      refetchQueries: ["QueuedPostsForChannel"]
    }
  })
)(ChannelPage);
