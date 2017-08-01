// @flow
import { graphql } from "react-apollo";
// import type { OperationComponent, QueryProps } from "react-apollo";

import addCollectionMutation from "../queries/add-collection-mutation.gql";
import sidebarQuery from "../queries/sidebar-query.gql";

import React, { Component } from "react";
import CollectionForm from "../components/collection-form";

const emptyCollection = {
  name: ""
};

class CollectionNewPage extends Component {
  handleSubmit = values => {
    const { onAddCollection, history } = this.props;
    return onAddCollection(values).then(collection => {
      history.replace(`/collections/${collection.id}`);
      return collection;
    });
  };

  render() {
    return (
      <div>
        <header className="heading">
          <h1>Create a new collection</h1>
        </header>
        <section>
          <CollectionForm
            collection={emptyCollection}
            onSubmit={this.handleSubmit}
          />
        </section>
      </div>
    );
  }
}

export default graphql(addCollectionMutation, {
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
})(CollectionNewPage);
