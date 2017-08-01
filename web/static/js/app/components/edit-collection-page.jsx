// @flow
import React, { Component } from "react";
import CollectionForm from "./collection-form";

class EditCollectionPage extends Component {
  handleSubmit = params => {
    const { handleUpdate, match: { params: { id } }, history } = this.props;
    const input = { id, ...params };
    return handleUpdate(input).then(collection => {
      history.push(`/collections/${collection.id}`);
      return collection;
    });
  };

  render() {
    const { data: { loading, error, collection } } = this.props;
    if (loading) {
      return <div>Loading</div>;
    }

    if (error) {
      return (
        <div>
          {error.message}
        </div>
      );
    }

    return (
      <div>
        <header className="heading">
          <h1>Editing Collection</h1>
        </header>
        <section>
          <CollectionForm
            collection={collection}
            onSubmit={this.handleSubmit}
          />
        </section>
      </div>
    );
  }
}

export default EditCollectionPage;
