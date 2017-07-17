// @flow
import { graphql } from "react-apollo";
import type { OperationComponent, QueryProps } from "react-apollo";
import Loadable from "react-loadable";

import { LoadingComponent } from "components/async-component";
import accountPageQuery from "../queries/account-page-query.gql";
import updateUserPreferences from "../queries/update-user-preferences.gql";

export type AccountPageProps = {
  data: AccountPageQuery & QueryProps
};

const AccountPage: OperationComponent<
  AccountPageQuery,
  {},
  AccountPageProps
  > = graphql(accountPageQuery)(graphql(updateUserPreferences, {
    props: ({ mutate }) => ({
      updatePreferences: preferences => mutate({ variables: { input: preferences } })
    })
  })(
  Loadable({
    loader: () => import(/* webpackChunkName: "account-page" */"../../components/account"),
    loading: LoadingComponent
  })
));

export default AccountPage;
