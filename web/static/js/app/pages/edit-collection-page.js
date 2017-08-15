// @flow
import { graphql } from "react-apollo";

import editCollectionPageQuery from "../queries/edit-collection-page.gql";
import updateCollection from "../queries/update-collection.gql";
import { ExtraLoadable } from "../../components/async-component";

const EditCollectionPage = graphql(editCollectionPageQuery, {
  options: ({ match }) => ({ variables: { id: match.params.id } })
})(
  graphql(updateCollection, {
    props: ({ mutate }) => ({
      handleUpdate: input =>
        mutate({ variables: { input } }).then(
          ({
            data: { updateCollection: { collectionErrors, collection } }
          }) => {
            if (collection) return collection;
            return Promise.reject(collectionErrors);
          }
        )
    })
  })(
    ExtraLoadable({
      loader: () =>
        import(/* webpackChunkName: "edit-collection-page" */
        "../components/edit-collection-page")
    })
  )
);

export default EditCollectionPage;
