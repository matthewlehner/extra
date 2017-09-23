// @flow
import React from "react";

import type { ChannelPageProps } from "../pages/channel";
import DocumentHead from "./document-head";
import Schedule from "../../components/schedule";
import QueuedPosts from "../../components/queued-posts";

const ChannelPage = ({
  updateSchedule,
  addTimeslot,
  removeTimeslot,
  data: { loading, error, schedule, channel, collections, recurrenceType }
}: ChannelPageProps) => {
  const scheduleProps = {
    addTimeslot,
    removeTimeslot,
    updateSchedule,
    schedule,
    collections,
    recurrenceType
  };

  return (
    <div>
      <DocumentHead title={`${channel.name} ${channel.provider} account`} />

      <header className="heading">
        <div className="heading__body">
          <figure className="heading__figure">
            <img src={channel.image} alt="Profile" />
          </figure>
          <h1>
            {channel.name}
          </h1>
          <p>
            {channel.provider} account
          </p>
        </div>
        <div className="button button_small">Delete account</div>
      </header>

      <Schedule {...scheduleProps} />

      <QueuedPosts channelId={channel.id} />
    </div>
  );
};

export default ChannelPage;
