// @flow
import { graphql } from "react-apollo";
import type { OperationComponent, QueryProps } from "react-apollo";
import { PageLoader } from "../../components/async-component";

import accountPage from "../queries/account-page-query.gql";
import updateUserPreferences from "../queries/update-user-preferences.gql";
import updatePassword from "../queries/update-user-password-mutation.gql";

export type AccountPageProps = {
  data: AccountPageQuery & QueryProps
};

const accountPageQuery = graphql(accountPage);
const updatePreferencesMutation = graphql(updateUserPreferences, {
  props: ({ mutate }) => ({
    updatePreferences: preferences =>
      mutate({ variables: { input: preferences } })
  })
});
const updatePasswordMutation = graphql(updatePassword, {
  props: ({ mutate }) => ({
    updatePassword: input => mutate({ variables: { input } })
  })
});

const AccountPage: OperationComponent<
  AccountPageQuery,
  {},
  AccountPageProps
> = accountPageQuery(
  updatePreferencesMutation(
    updatePasswordMutation(
      PageLoader(() =>
        import(/* webpackChunkName: "account-page" */
        "../../components/account")
      )
    )
  )
);

export default AccountPage;
