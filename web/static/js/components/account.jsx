// @flow

import React from "react";
import { Form, Select, Label } from "lib/forms";
import timezones from "../lib/timezones";

import { form } from "./account.scss";

const Account = () =>
  <div>
    <header className="heading">
      <h1>Account</h1>
    </header>

    <section>
      <h2>Preferences</h2>
      <Form className={form}>
        <Label htmlFor="user[email_address]">Email Address</Label>
        <input
          id="user[email_address]"
          type="email"
          defaultValue="matthew@mpl.io"
        />

        <Label htmlFor="user[timezone]">Timezone</Label>
        <Select options={timezones} />

        <button className="button">KANYE</button>
      </Form>
    </section>

    <section>
      <h2>Password</h2>
      <Form className={form}>
        <Label htmlFor="user[current_password]">Current Password</Label>
        <input id="user[current_password]" type="password" />

        <Label htmlFor="user[current_password]">New Password</Label>
        <input id="user[current_password]" type="password" />

        <button className="button">KANYE</button>
      </Form>
    </section>
  </div>;

export default Account;
