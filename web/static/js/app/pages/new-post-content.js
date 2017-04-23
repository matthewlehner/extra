import { graphql } from "react-apollo";
import SidebarQuery from "app/queries/sidebar-query.gql";
import NewPostContent from "components/new-post-content";

export default graphql(SidebarQuery)(NewPostContent);
