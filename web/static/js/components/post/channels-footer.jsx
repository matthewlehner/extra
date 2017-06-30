// @flow

import React from "react";
import { Link } from "react-router-dom";
import ChannelLogo from "../channel-logo";
import {
  channelBadge,
  footer,
  providerImg,
  postChannels,
  actions
} from "./post.scss";

const ChannelAvatar = ({ name, image, provider }: Extra$Channel) =>
  <li className={channelBadge}>
    <img className={providerImg} src={image} alt={`${provider}: ${name}`} />
    <ChannelLogo
      provider={provider}
      style={{ top: "1.125rem", left: "1.125rem" }}
    />
  </li>;

type Props = { id: string, channels: Array<Extra$Channel> };
const PostChannelsFooter = ({ id, channels }: Props) =>
  <footer className={footer}>
    <nav className={actions}>
      here is some text, too
      <Link to={`/post/${id}`}>Edit</Link>
      <Link to="#">Archive</Link>
    </nav>
    <ul className={postChannels}>
      {channels.map(channel => <ChannelAvatar key={channel.id} {...channel} />)}
    </ul>
  </footer>;

export default PostChannelsFooter;
