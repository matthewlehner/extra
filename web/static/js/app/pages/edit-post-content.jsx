// @flow
import { graphql } from "react-apollo";
import type { OperationComponent, QueryProps } from "react-apollo";
import type { Match } from "react-router-dom";

import getPostQuery from "../queries/get-post-content-query.gql";
import EditPostModal from "../components/edit-post-modal";

export type EditPostProps = {
  data: GetPostContentQuery & QueryProps,
  match: Match
};

const EditPostPage: OperationComponent<
  GetPostContentQuery,
  {},
  EditPostProps
> = graphql(getPostQuery, {
  options: ({ match }: EditPostProps) => ({
    variables: { id: match.params.postId }
  })
})(EditPostModal);

export default EditPostPage;
