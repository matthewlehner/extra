// @flow
import React from "react";
import { CSSTransition } from "react-transition-group";
import type { Notification } from "./store";

export default function FlashMessage({
  body,
  timestamp,
  type,
  id
}: Notification) {
  return (
    <CSSTransition
      key={id}
      classNames="flash-transition"
      timeout={{ enter: 1000, exit: 250 }}
    >
      <div className={`flash_message flash_message__${type}`}>
        {body}
      </div>
    </CSSTransition>
  );
}
