// @flow
import React, { PureComponent } from "react";
import LinkButton from "components/ui/link-button";
import Icon from "components/icon";

export default class Modal extends PureComponent {
  props: {
    title: string | null,
    children: React.Children,
    onDismiss: SyntheticEvent => void
  };

  static defaultProps = {
    children: null
  };

  componentDidMount() {
    if (document && document.body instanceof HTMLElement) {
      document.body.classList.add("modal-open");
    }
  }

  componentWillUnmount() {
    if (document && document.body instanceof HTMLElement) {
      document.body.classList.remove("modal-open");
    }
  }

  handleClick = (event: SyntheticEvent): void => {
    if (event.currentTarget === event.target) {
      this.props.onDismiss(event);
    }
  };

  render() {
    const { children, title } = this.props;

    return (
      /*  eslint-disable jsx-a11y/click-events-have-key-events */
      /*  eslint-disable jsx-a11y/no-noninteractive-element-interactions */
      <div className="modal__overlay" onClick={this.handleClick} role="dialog">
        <div className="modal__container">
          <header className="modal__header">
            <LinkButton className="modal__dismiss" onClick={this.handleClick}>
              <Icon name="close" width="0.75rem" height="0.75rem" />
            </LinkButton>
            {title
              ? <h2>
                  {title}
                </h2>
              : null}
          </header>
          <div className="modal__body">
            {children}
          </div>
        </div>
      </div>
    );
  }
}
