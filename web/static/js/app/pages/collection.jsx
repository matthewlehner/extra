// @flow
import { graphql } from "react-apollo";
import type { OperationComponent, QueryProps } from "react-apollo";
import type { Match, Location } from "react-router-dom";

import collectionPageQuery from "../queries/collection-page.gql";
import { PageLoader } from "../../components/async-component";

export type CollectionPageProps = {
  data: CollectionPageQuery & QueryProps,
  match: Match,
  location: Location
};

const CollectionPage: OperationComponent<
  CollectionPageQuery,
  {},
  CollectionPageProps
> = graphql(collectionPageQuery, {
  options: ({ match }) => ({ variables: { id: match.params.id } })
})(
  PageLoader(() =>
    import(/* webpackChunkName: "collection-page" */
    "../../components/show-collection")
  )
);

export default CollectionPage;
