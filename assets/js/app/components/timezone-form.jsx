// @flow
import React, { Component } from "react";
import { Formik } from "formik";
import { object, string } from "yup";

import { addMessage } from "../notifications/store";
import timezones, { validTimezones } from "../../lib/timezones";
import Select from "../../lib/forms/select";
import { form, underlinedForm } from "../../components/account.scss";

class TimezoneForm extends Component {
  constructor(props) {
    super(props);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(e) {
    this.props.handleChange(e);
    this.props.submitForm();
  }

  render() {
    const { values, handleBlur, handleSubmit } = this.props;

    return (
      <form className={`${form} ${underlinedForm}`} onSubmit={handleSubmit}>
        <label htmlFor="schedule[timezone]">Timezone</label>
        <Select
          id="schedule[timezone]"
          name="timezone"
          options={timezones}
          placeholder=" "
          value={values.timezone}
          onChange={this.handleChange}
          onBlur={handleBlur}
        />
      </form>
    );
  }
}

function handleSubmit(payload, { props, setError, setSubmitting }) {
  debugger;
  props.updateSchedule(payload).then(
    res => {
      setSubmitting(false);
      addMessage({ body: "Timezone updated successfully" });
    },
    error => {
      setSubmitting(false);
      setError(error);
    }
  );
}

const TimezoneFormLogic = Formik({
  validationSchema: object().shape({
    timezone: string().required().oneOf(validTimezones()).default("")
  }),
  mapPropsToValues: ({ timezone }) => ({ timezone }),
  handleSubmit
});

export default TimezoneFormLogic(TimezoneForm);
