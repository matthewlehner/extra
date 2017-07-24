// @flow
import { graphql } from "react-apollo";
import type { OperationComponent, QueryProps } from "react-apollo";
import type { Location } from "react-router-dom";

import collectionPageQuery from "../queries/collection-page.gql";
import ShowCollection from "../../components/show-collection";

export type CollectionPageProps = {
  data: CollectionPageQuery & QueryProps,
  location: Location
};

const CollectionPage: OperationComponent<
  CollectionPageQuery,
  {},
  CollectionPageProps
> = graphql(collectionPageQuery, {
  options: ({ match }) => ({ variables: { id: match.params.id } })
})(ShowCollection);

export default CollectionPage;
