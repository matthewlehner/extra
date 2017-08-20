// @flow
import { graphql, compose } from "react-apollo";
import type { OperationComponent, QueryProps } from "react-apollo";
import { PageLoader } from "../../components/async-component";

import channelPageQuery from "../queries/channel-page.gql";
import addTimeslotMutation from "../queries/add-timeslot-mutation.gql";
import removeTimeslotMutation from "../queries/remove-timeslot-mutation.gql";

export type ChannelPageProps = {
  data: ChannelPageQuery & QueryProps,
  addTimeslot: ({ variables: AddTimeslotMutationVariables }) => void,
  removeTimeslot: ({ id: string }) => void
};

const ChannelPageComponent: OperationComponent<
  ChannelPageQuery,
  {},
  ChannelPageProps
> = compose(
  graphql(channelPageQuery, {
    options: ({ match }) => ({ variables: { id: match.params.id } })
  }),
  graphql(addTimeslotMutation, {
    name: "addTimeslot",
    options: props => ({
      updateQueries: {
        ChannelPage: (previousData, { mutationResult }) => {
          const newTimeslot = mutationResult.data.addTimeslot;
          return {
            ...previousData,
            schedule: {
              ...previousData.schedule,
              timeslots: [...previousData.schedule.timeslots, newTimeslot]
            }
          };
        }
      },
      refetchQueries: ["QueuedPostsForChannel"]
    })
  }),
  graphql(removeTimeslotMutation, {
    props: ({ mutate }) => ({
      removeTimeslot: id => mutate({ variables: { id } })
    }),
    options: ({ match: { params: { id } } }) => ({
      refetchQueries: [{ query: channelPageQuery, variables: { id } }]
    })
  })
)(
  PageLoader(() =>
    import(/* webpackChunkName: "channel-page" */ "../components/channel-page")
  )
);

export default ChannelPageComponent;
