// @flow
import { graphql } from "react-apollo";
import type { OperationComponent, QueryProps } from "react-apollo";
import type { Location } from "react-router-dom";

import editCollectionPageQuery from "../queries/edit-collection-page.gql";
import { ExtraLoadable } from "../../components/async-component";

const EditCollectionPage = graphql(editCollectionPageQuery, {
  options: ({ match }) => ({ variables: { id: match.params.id } })
})(
  ExtraLoadable({
    loader: () =>
      import(/* webpackChunkName: "edit-collection-page" */
      "../components/edit-collection-page")
  })
);

export default EditCollectionPage;
