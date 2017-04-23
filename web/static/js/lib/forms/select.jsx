// @flow

import React from "react";

const Select = (
  { options }: { options: Array<{ value: string, label: string}> }
) => (
  <div className="select">
    <select
      className="form__control"
      id="post_content_post_collection_id"
      name="post_content[post_collection_id]"
      required="required"
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
