// @flow

import React from "react";
import { Link } from "react-router-dom";

type Props = {
  title?: string,
  children?: React.Children,
  cancelPath: string,
  onDismiss(func: () => void): void
};

function handleClick(event:MouseEvent, action:Function) {
  // Don't doesn't trigger action if not clicking on the actual element
  if (event.currentTarget !== event.target) return;
  action();
}

const Modal = ({ children, onDismiss, cancelPath, title }: Props) => (
  /*  eslint-disable jsx-a11y/no-static-element-interactions */
  <div className="modal__overlay" onClick={event => handleClick(event, onDismiss)}>
    <div className="modal__container">
      <header className="modal__header">
        <Link className="modal__dismiss" to={cancelPath}>
          &times;
        </Link>
        { title
            ? <h2>{ title }</h2>
            : null }
      </header>
      <div className="modal__body">
        {children}
      </div>
    </div>
  </div>
);

Modal.defaultProps = {
  title: null,
  children: null
};

export default Modal;
