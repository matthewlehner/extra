// @flow

import React from "react";
import { list } from "./post.scss";

const PostList = ({ children }: { children?: React$Element<*> }) => (
  <ul className={list}>
    {children}
  </ul>
);

PostList.defaultProps = {
  children: null
};

export default PostList;
