import { graphql, compose } from "react-apollo";
import newPostContentForm from "app/queries/new-post-content-query.gql";
import addPostContent from "app/queries/add-post-content-mutation.gql";
import NewPostContent from "components/new-post-content";

export default compose(
  graphql(newPostContentForm, {
    options: ({ match }) => ({ variables: { collectionId: match.params.id } })
  }),
  graphql(addPostContent, {
    name: "addPostContent",
    options: {
      updateQueries: {
        CollectionPage: (previousData, { mutationResult }) => ({
          ...previousData,
          collection: {
            ...previousData.collection,
            posts: [...previousData.collection.posts, mutationResult.data.addPost]
          }
        })
      }
    }
  })
)(NewPostContent);
