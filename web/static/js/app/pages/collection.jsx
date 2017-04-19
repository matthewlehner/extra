// @flow

import { graphql } from "react-apollo";
import CollectionPageQuery from "app/queries/collection-page.gql";
import ShowCollection from "components/show-collection";

export default graphql(
  CollectionPageQuery,
  {
    options: ({ match }) => ({ variables: { id: match.params.id } })
  }
)(ShowCollection);
