// @flow
import React, { Component } from "react";

import type { CollectionProps } from "app/pages/channel";
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
    recurrenceType: Recurrence
  };

  state = {
    showForm: false,
    timeslot: timeslotDefaults
  };

  onAddTimeslot = values => {
    const variables = {
      ...values,
      time: `${values.time}:00`,
      scheduleId: this.props.scheduleId
    };
    this.props.addTimeslot({ variables }).then(response => {
      this.setState(() => ({ showForm: false }));
      return response;
    });
  };

  hideForm = (event: Event) => {
    event.preventDefault();
    this.setState(() => ({ showForm: false }));
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
      recurrenceType: { enumValues: recurrences },
      collections
    } = this.props;

    return (
      <TimeslotForm
        onAddTimeslot={this.onAddTimeslot}
        recurrences={recurrences}
        collections={collections}
        onCancel={this.hideForm}
      />
    );
  }
}
