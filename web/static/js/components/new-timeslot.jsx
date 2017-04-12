import React, { Component, PropTypes } from "react";
import { graphql } from "react-apollo";

import timeslotFieldInfo from "app/queries/timeslot-field-info-query.gql";
import addTimeslotMutation from "app/queries/add-timeslot-mutation.gql";

import TimeslotForm from "components/timeslot-form";

const timeslotDefaults = {
  time: "",
  recurrence: "",
  collectionId: ""
};

class NewTimeslot extends Component {
  static propTypes = {
    addTimeslot: PropTypes.func.isRequired,
    scheduleId: PropTypes.string.isRequired,
    data: PropTypes.shape({
      collections: PropTypes.array,
      recurrenceType: PropTypes.object
    }).isRequired
  }

  constructor(props) {
    super(props);

    this.state = {
      showForm: false,
      timeslot: timeslotDefaults
    };
  }

  onSubmit = (event) => {
    this.hideForm(event);
    this.props.addTimeslot({
      variables: {
        scheduleId: this.props.scheduleId,
        ...this.state.timeslot
      }
    });
  }

  setTimeslotState = (key, value) => {
    this.setState(({ timeslot }) => ({
      timeslot: { ...timeslot, [key]: value }
    }));
  }

  hideForm = (event) => {
    event.preventDefault();
    this.setState(() => ({ showForm: false, timeslot: timeslotDefaults }));
  }

  showForm = (event) => {
    event.preventDefault();
    this.setState(() => ({ showForm: true }));
  }

  render() {
    if (this.state.showForm) {
      const {
        recurrenceType: { enumValues: recurrenceValues },
        collections
      } = this.props.data;

      const { timeslot } = this.state;

      const formProps = {
        time: {
          value: timeslot.time,
          onChange: event => (this.setTimeslotState("time", event.target.value))
        },
        recurrence: {
          options: recurrenceValues,
          value: timeslot.recurrence,
          onChange: event => (
            this.setTimeslotState("recurrence", event.target.value)
          )
        },
        collection: {
          options: collections,
          value: timeslot.collectionId,
          onChange: event => (
            this.setTimeslotState("collectionId", event.target.value)
          )
        },
        onCancel: this.hideForm,
        onSubmit: this.onSubmit
      };

      return <TimeslotForm {...formProps} />;
    }

    return <button onClick={this.showForm}>Add new time slot</button>;
  }
}

export default graphql(timeslotFieldInfo)(
  graphql(
    addTimeslotMutation,
    {
      name: "addTimeslot",
      options: {
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
        }
      }
    }
  )(
    NewTimeslot
  )
);
