// @flow
import React from "react";
import { Form, Select, Label } from "lib/forms";
import timezones from "../lib/timezones";
import UserPreferencesForm from "../app/components/user-preferences-form";
import UserPasswordForm from "../app/components/user-password-form";
import { form, formActions } from "./account.scss";

import type { AccountPageProps } from "../app/pages/account";

const Account = ({
  data: { loading, error, userPreferences },
  updatePreferences,
  updatePassword
}: AccountPageProps) => {
  if (loading) {
    return <div>Loading</div>;
  }

  if (error) {
    return (
      <div>
        Error: {error.message}
      </div>
    );
  }

  return (
    <div>
      <header className="heading">
        <h1>Account</h1>
      </header>

      <section>
        <h2>Preferences</h2>
        <UserPreferencesForm
          formData={userPreferences}
          updatePreferences={updatePreferences}
        />
      </section>

      <section>
        <h2>Password</h2>
        <UserPasswordForm updatePassword={updatePassword} />
      </section>
    </div>
  );
};

export default Account;
