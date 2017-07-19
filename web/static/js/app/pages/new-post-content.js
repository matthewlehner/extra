// @flow
import { graphql, compose } from "react-apollo";
import type { OperationComponent, QueryProps } from "react-apollo";
import type { Match, RouterHistory } from "react-router-dom";

import newPostContentForm from "app/queries/new-post-content-query.gql";
import addPostContent from "app/queries/add-post-content-mutation.gql";
import NewPostContent from "components/new-post-content";

export type NewPostContentProps = {
  data: NewPostContentFormQuery & QueryProps,
  match: Match,
  history: RouterHistory,
  addPostContent: ({ variables: AddPostContentMutationVariables }) => Promise<*>
};

const NewPostContentPage: OperationComponent<
  NewPostContentFormQuery,
  {},
  NewPostContentProps
> = compose(
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
            posts: [
              ...previousData.collection.posts,
              mutationResult.data.addPost
            ]
          }
        })
      }
    }
  })
)(NewPostContent);

export default NewPostContentPage;
