// @flow

import React from "react";
import Icon from "../../components/icon";

// function handleChange(event, fieldName, callback) {
//   event.preventDefault();
// }

const CheckboxCollection = (
  { options, fieldName, onChange, value: checkboxValues }: {
    options: Array<{ value: string, label: string, provider: string }>,
    fieldName: string,
    onChange: (string, {}) => void,
    value: {}
  }
) => {
  const handleChange = (event, id) => {
    const newValue = { ...checkboxValues, [id]: event.currentTarget.checked };
    onChange(fieldName, newValue);
  };

  return (
    <div className="form__collection-wrapper">
      {
        options.map(({ value, label }) => (
          <label key={value} htmlFor={`${fieldName}-${value}`}>
            <input
              className="form__control"
              type="checkbox"
              id={`${fieldName}-${value}`}
              checked={checkboxValues[value] || false}
              onChange={event => handleChange(event, value)}
            />
            <span className="form__indicator form__indicator_checkbox">
              <Icon className="icon icon_checkmark" name="checkmark" />
            </span>
            {label}
          </label>
        ))
      }
    </div>
  );
};

export default CheckboxCollection;
