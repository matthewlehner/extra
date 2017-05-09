// @flow

import React from "react";
import Style from "./post.scss"

type Props = {
  id: string,
  children: React$Element
};

const Post = ({ id, children }) => (
  <li className={Style.post}>
    { children }
  </li>
);

export default Post;
