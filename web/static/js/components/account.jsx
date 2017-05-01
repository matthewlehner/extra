// @flow

import React from "react";
import {
  Form,
  Field
} from "lib/forms";

const Account = () => (
  <div>
    <header className="heading">
      <h1>Account</h1>
    </header>

    <section>
      <Form>
        <Field label="Email Address">
          <input />
        </Field>
        <button>Update email address</button>
      </Form>
    </section>
  </div>
);

export default Account;
