import { graphql, compose } from "react-apollo";
import SidebarQuery from "app/queries/sidebar-query.gql";
import addPostContent from "app/queries/add-post-content-mutation.gql";
import NewPostContent from "components/new-post-content";

export default compose(
  graphql(SidebarQuery),
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
