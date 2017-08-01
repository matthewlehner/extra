// @flow
import React from "react";
import CollectionForm from "./collection-form";

const EditCollectionPage = ({ data: { loading, error, collection } }) => {
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
        <CollectionForm collection={collection} onSubmit={handleSubmit} />
      </section>
    </div>
  );
};

function handleSubmit() {}

export default EditCollectionPage;
