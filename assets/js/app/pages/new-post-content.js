// @flow
import { graphql, compose } from "react-apollo";
import type { OperationComponent, QueryProps } from "react-apollo";
import type { Match, RouterHistory } from "react-router-dom";

import newPostContentForm from "app/queries/new-post-content-query.gql";
import addContent from "app/queries/add-post-content-mutation.gql";
import NewPostContent from "components/new-post-content";

export type NewPostContentProps = {
  data: NewPostContentFormQuery & QueryProps,
  match: Match,
  history: RouterHistory,
  addContent: ({ variables: addContentMutationVariables }) => Promise<*>
};

const NewPostContentPage: OperationComponent<
  NewPostContentFormQuery,
  {},
  NewPostContentProps
> = compose(
  graphql(newPostContentForm, {
    options: ({ match }) => ({ variables: { collectionId: match.params.id } })
  }),
  graphql(addContent, {
    props: ({ mutate }) => ({
      onAddContent: input =>
        mutate({
          variables: { input }
        }).then(response => {
          const { data: { addContent: { content, contentErrors } } } = response;
          if (content) return content;
          return Promise.reject(contentErrors);
        })
    }),
    options: ({ match: { params } }) => ({
      updateQueries: {
        CollectionPage: (previousData, { mutationResult }) => ({
          ...previousData,
          collection: {
            ...previousData.collection,
            posts: [
              ...previousData.collection.posts,
              mutationResult.data.addContent.content
            ]
          }
        })
      }
    })
  })
)(NewPostContent);

export default NewPostContentPage;
