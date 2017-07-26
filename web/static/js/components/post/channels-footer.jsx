// @flow
import React from "react";
import { Link } from "react-router-dom";
import LinkButton from "../ui/link-button";

import Icon from "../icon";
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

type Props = {
  id: string,
  channels: Array<Extra$Channel>,
  collectionPath: string,
  onArchive: () => void
};

const PostChannelsFooter = ({
  id,
  channels,
  onArchive,
  collectionPath
}: Props) =>
  <footer className={footer}>
    <nav className={actions}>
      <Link to={`${collectionPath}/edit-post/${id}`}>
        <Icon name="edit" width={"1.125rem"} height={"1.125rem"} />
        Edit
      </Link>
      <LinkButton onClick={onArchive}>
        <Icon name="archive" width={"1.125rem"} height={"1.125rem"} />
        Archive
      </LinkButton>
    </nav>
    <ul className={postChannels}>
      {channels.map(channel => <ChannelAvatar key={channel.id} {...channel} />)}
    </ul>
  </footer>;

export default PostChannelsFooter;
