// @flow
import { ApolloClient,
         createNetworkInterface } from "react-apollo";
import getCsrfToken from "../lib/csrfToken";

const networkInterface = createNetworkInterface({
  uri: "/graphql",
  opts: {
    credentials: "same-origin",
    headers: {
      "x-csrf-token": getCsrfToken()
    }
  }
});

const client = new ApolloClient({ networkInterface });

export default client;
