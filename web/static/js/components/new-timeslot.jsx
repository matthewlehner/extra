import React, { Component } from "react";
import { graphql } from "react-apollo";

import timeslotFieldInfo from "app/queries/timeslot-field-info-query.gql";

import TimeslotForm from "components/timeslot-form";

class NewTimeslot extends Component {
  constructor(props) {
    super(props);

    this.state = {
      showForm: false,
      timeslotValues: {}
    };
  }

  showForm = (event) => {
    event.preventDefault();
    this.setState(() => ({ showForm: true }));
  }

  hideForm = (event) => {
    event.preventDefault();
    this.setState(() => ({ showForm: false, timeslotValues: {} }));
  }

  selectRecurrence = (event) => {
    const recurrence = event.target.value;
    this.setState(({ timeslotValues }) => ({
      timeslotValues: Object.assign({}, timeslotValues, { recurrence })
    }));
  }

  selectCollection = (event) => {
    const collectionId = event.target.value;
    this.setState(({ timeslotValues }) => ({
      timeslotValues: Object.assign({}, timeslotValues, { collectionId })
    }));
  }

  render() {
    if (this.state && this.state.showForm) {
      const {
        data: { recurrenceType: { enumValues: recurrenceValues }, collections }
      } = this.props;

      const formProps = {
        recurrenceValues,
        collections,
        values: this.state.timeslotValues,
        selectRecurrence: this.selectRecurrence,
        selectCollection: this.selectCollection,
        onCancel: this.hideForm,
        onSubmit: () => {}
      };

      return <TimeslotForm {...formProps} />;
    }

    return <button onClick={this.showForm}>Add new time slot</button>;
  }
}

export default graphql(timeslotFieldInfo)(NewTimeslot);
