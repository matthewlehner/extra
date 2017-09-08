// @flow

import React from "react";
import Style from "./post.scss";

type Props = {
  children?: React$Element<*>
};

const Post = ({ children }: Props) => (
  <li className={Style.post}>
    { children }
  </li>
);

Post.defaultProps = {
  children: null
};

export default Post;
