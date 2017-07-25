// @flow
import { graphql } from "react-apollo";
import type { OperationComponent, QueryProps } from "react-apollo";
import type { Match, RouterHistory } from "react-router-dom";

import { ExtraLoadable } from "../../components/async-component";
import getPostQuery from "../queries/get-post-content-query.gql";
import updatePostContent from "../queries/update-post-content-mutation.gql";

export type EditPostProps = {
  data: GetPostContentQuery & QueryProps,
  match: Match,
  history: RouterHistory,
  onUpdatePost: (UpdatePostContentPayload) => void
};

const EditPostPage: OperationComponent<
  GetPostContentQuery,
  {},
  EditPostProps
> = graphql(getPostQuery, {
  options: ({ match }: EditPostProps) => ({
    variables: { id: match.params.postId }
  })
})(graphql(updatePostContent, {
  props: ({ mutate }) => ({ onUpdatePost: mutate })
})(ExtraLoadable({
  loader: () => import(
    /* webpackChunkName: "edit-post-modal" */
    "../components/edit-post-modal"
  )
})));

export default EditPostPage;
