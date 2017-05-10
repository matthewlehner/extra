// @flow

import React from "react";
import Style from "./post.scss";

const PostChannelsFooter = (
  { channels }: { channels: Array<Extra$Channel> }
) => (
  <footer className={Style.footer}>
    { channels.map(({ id, name }) => (
      <span key={id} className={Style.channelBadge}>
        {name}
      </span>
    ))}
  </footer>
);

export default PostChannelsFooter;
