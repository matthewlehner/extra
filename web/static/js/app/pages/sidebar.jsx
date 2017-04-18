// @flow

import { graphql } from "react-apollo";
import SidebarQuery from "app/queries/sidebar-query.gql";
import Sidebar from "components/sidebar";

export default graphql(SidebarQuery)(Sidebar);
