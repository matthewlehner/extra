// @flow
import React, { PureComponent } from "react";
import CollectionForm from "./collection-form";

export default class NewCollection extends PureComponent {
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
          <CollectionForm onSubmit={this.handleSubmit} />
        </section>
      </div>
    );
  }
}
