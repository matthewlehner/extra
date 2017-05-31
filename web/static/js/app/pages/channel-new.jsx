// @flow
import React from "react";
import Icon from "components/icon";

const ChannelNewPage = () => (
  <div>
    <header className="heading">
      <h1>Add a new channel</h1>
    </header>

    <section>
      <h2>Type</h2>
    </section>

    <section className="new-social-channel__section">
      <h3 className="social-logo social-logo_twitter">
        <Icon name="twitter" />
        <span>Twitter</span>
      </h3>

      <ul className="new-social-channel__ul">
        <li className="new-social-channel__li">
          <a
            href="/auth/twitter"
            className="button button_small button_twitter"
          >
            Add an account
          </a>
        </li>
      </ul>
    </section>
  </div>
);

export default ChannelNewPage;
