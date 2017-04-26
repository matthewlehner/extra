// @flow

import React from "react";

type Props = {
  title?: string,
  children?: React.Children,
  onDismiss: () => void
};

const Modal = ({ children, onDismiss, title }: Props) => {
  const handleClick = (event:MouseEvent): void => {
    if (event.currentTarget === event.target) {
      onDismiss();
    }
  };

  return (
    /*  eslint-disable jsx-a11y/no-static-element-interactions */
    <div
      className="modal__overlay"
      onClick={handleClick}
    >
      <div className="modal__container">
        <header className="modal__header">
          <button className="modal__dismiss" onClick={handleClick}>
            &times;
          </button>
          { title ? <h2>{ title }</h2> : null }
        </header>
        <div className="modal__body">
          {children}
        </div>
      </div>
    </div>
  );
};


Modal.defaultProps = {
  title: null,
  children: null
};

export default Modal;
