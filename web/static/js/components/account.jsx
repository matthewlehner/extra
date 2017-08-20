// @flow
import React from "react";
import DocumentHead from "../app/components/document-head";
import UserPreferencesForm from "../app/components/user-preferences-form";
import UserPasswordForm from "../app/components/user-password-form";

import type { AccountPageProps } from "../app/pages/account";

const Account = ({
  data: { loading, error, userPreferences },
  updatePreferences,
  updatePassword
}: AccountPageProps) =>
  <div>
    <DocumentHead title="Account Preferences" />
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
  </div>;

export default Account;
