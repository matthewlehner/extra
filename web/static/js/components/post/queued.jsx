// @flow

import React from "react";

import Post from "./index";
import Style from "./post.scss";

type Props = { scheduledFor: Date, postContent: Extra$PostContent };

const QueuedPost = ({ scheduledFor, postContent }: Props) => {
  const postTime = new Date(scheduledFor).toString();

  return (
    <Post>
      { postContent
          ? postContent.body
          : "Empty queue slot" }
      <footer className={Style.footer}>
        Scheduled For: <time dateTime={scheduledFor}>{postTime}</time>
      </footer>
    </Post>
  );
};

export default QueuedPost;
