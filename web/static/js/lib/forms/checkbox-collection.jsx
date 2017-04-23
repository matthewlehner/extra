// @flow

import React from "react";
import Icon from "../../components/icon";

const CheckboxCollection = (
  { options }:{
    options: Array<{ value: string, label: string, provider: string }>
  }
) => (
  <div className="form__collection-wrapper">
    {
      options.map(({ value, label }) => (
        <label key={value} htmlFor={`${label}-${value}`}>
          <input
            className="form__control"
            type="checkbox"
            id={`${label}-${value}`}
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

export default CheckboxCollection;
