// @flow

import React, { Component } from "react";

import type { CollectionProps, RecurrenceProps } from "app/pages/channel";
import TimeslotForm from "./timeslot-form";

const timeslotDefaults = {
  time: "",
  recurrence: "",
  collectionId: ""
};

export default class NewTimeslot extends Component {
  props: {
    addTimeslot: Function,
    scheduleId: string,
    collections: Array<CollectionProps>,
    recurrenceType: RecurrenceProps
  };

  state = {
    showForm: false,
    timeslot: timeslotDefaults
  };

  onSubmit = (event: Event) => {
    this.hideForm(event);
    this.props.addTimeslot({
      variables: {
        scheduleId: this.props.scheduleId,
        ...this.state.timeslot
      }
    });
  }

  setTimeslotState = (key:string, value:string) => {
    this.setState(({ timeslot }) => ({
      timeslot: { ...timeslot, [key]: value }
    }));
  }

  hideForm = (event: Event) => {
    event.preventDefault();
    this.setState(() => ({ showForm: false, timeslot: timeslotDefaults }));
  }

  showForm = (event: Event) => {
    event.preventDefault();
    this.setState(() => ({ showForm: true }));
  }

  render() {
    if (this.state.showForm) {
      const {
        recurrenceType: { enumValues: recurrenceValues },
        collections
      } = this.props;

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
