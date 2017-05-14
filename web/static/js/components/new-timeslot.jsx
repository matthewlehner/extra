// @flow

import React, { Component } from "react";

import type { CollectionProps, RecurrenceProps } from "app/pages/channel";
import LinkButton from "components/ui/link-button";
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
  };

  setTimeslotState = (key: string, value: string) => {
    this.setState(({ timeslot }) => ({
      timeslot: { ...timeslot, [key]: value }
    }));
  };

  hideForm = (event: Event) => {
    event.preventDefault();
    this.setState(() => ({ showForm: false, timeslot: timeslotDefaults }));
  };

  showForm = (event: Event) => {
    event.preventDefault();
    this.setState(() => ({ showForm: true }));
  };

  render() {
    if (this.state.showForm === false) {
      return <LinkButton onClick={this.showForm}>Add new time slot</LinkButton>;
    }

    const {
      recurrenceType: { enumValues: recurrenceValues },
      collections
    } = this.props;

    const { timeslot } = this.state;

    const formProps = {
      time: {
        value: timeslot.time,
        onChange: this.setTimeslotState
      },
      recurrence: {
        options: recurrenceValues,
        value: timeslot.recurrence,
        onChange: this.setTimeslotState
      },
      collection: {
        options: collections,
        value: timeslot.collectionId,
        onChange: this.setTimeslotState
      },
      onCancel: this.hideForm,
      onSubmit: this.onSubmit
    };

    return <TimeslotForm {...formProps} />;
  }
}
