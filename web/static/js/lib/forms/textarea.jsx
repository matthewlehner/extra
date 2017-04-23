// @flow

import React from "react";

const Textarea = props => (
  <textarea {...props} />
);

Textarea.defaultProps = {
  className: "form__control"
};

export default Textarea;
