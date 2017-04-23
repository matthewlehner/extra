// @flow

import React from "react";
import { handleChange } from "./utils";

const Select = (
  { fieldName, options, onChange }: {
    fieldName: string,
    options: Array<{ value: string, label: string}>,
    onChange: (field: string, value: string) => void
  }
) => (
  <div className="select">
    <select
      className="form__control"
      id="post_content_post_collection_id"
      name="post_content[post_collection_id]"
      required="required"
      onChange={event => handleChange(event, fieldName, onChange)}
    >
      {
        options.map(
          ({ value, label }) => (
            <option value={value} key={value}>{label}</option>
          )
        )
      }
    </select>
  </div>
);

export default Select;
