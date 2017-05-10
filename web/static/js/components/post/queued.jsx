// @flow

import React from "react";

import Post from "./index";
import Style from "./post.scss";

const QueuedPost = ({ scheduledFor }:{ scheduledFor: Date }) => {
  const postTime = new Date(scheduledFor).toString();

  return (
    <Post>
      Empty queue slot
      <footer className={Style.footer}>
        Scheduled For: <time dateTime={scheduledFor}>{postTime}</time>
      </footer>
    </Post>
  );
};

export default QueuedPost;
