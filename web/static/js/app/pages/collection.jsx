// @flow
import { graphql } from "react-apollo";
import type { OperationComponent, QueryProps } from "react-apollo";
import type { Location } from "react-router-dom";

import collectionPageQuery from "../queries/collection-page.gql";
import { ExtraLoadable } from "../../components/async-component";

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
})(ExtraLoadable({
  loader: () => import(
    /* webpackChunkName: "collection-page" */
    "../../components/show-collection"
  )
}));

export default CollectionPage;
