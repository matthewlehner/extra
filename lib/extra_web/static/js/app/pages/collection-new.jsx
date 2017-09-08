// @flow
import { graphql } from "react-apollo";
// import type { OperationComponent, QueryProps } from "react-apollo";
import addCollectionMutation from "../queries/add-collection-mutation.gql";
import sidebarQuery from "../queries/sidebar-query.gql";

import { PageLoader } from "../../components/async-component";

const NewCollectionPage = graphql(addCollectionMutation, {
  props: ({ mutate }) => ({
    onAddCollection: input =>
      mutate({
        variables: { input }
      }).then(
        ({ data: { addCollection: { collectionErrors, collection } } }) => {
          if (collection) return collection;
          return Promise.reject(collectionErrors);
        }
      )
  }),
  options: props => ({
    update: (proxy, { data: { addCollection: { collection } } }) => {
      if (collection) {
        const data = proxy.readQuery({ query: sidebarQuery });
        data.collections.push(collection);
        proxy.writeQuery({ query: sidebarQuery, data });
      }
    }
  })
})(
  PageLoader(() =>
    import(/* webpackChunkName: "new-collection-page" */
    "../components/new-collection")
  )
);

export default NewCollectionPage;
