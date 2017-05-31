// @flow
import { ApolloClient,
         createNetworkInterface } from "react-apollo";

const csrfMetaEl: ?HTMLElement = document.querySelector(
  "meta[name='csrf-token']"
);
let csrfToken: string;

if (csrfMetaEl && csrfMetaEl instanceof HTMLMetaElement) {
  csrfToken = csrfMetaEl.content;
} else {
  csrfToken = "";
}

const networkInterface = createNetworkInterface({
  uri: "/graphql",
  opts: {
    credentials: "same-origin",
    headers: {
      "x-csrf-token": csrfToken
    }
  }
});

const client = new ApolloClient({ networkInterface });

export default client;
