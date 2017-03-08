import React, { PropTypes } from "react";

const ToggleSwitch = ({ checked, onChange }) => (
  <span className="toggle-switch">
    <input
      type="checkbox"
      name="checkbox"
      id="toggler"
      className="input"
      checked={checked}
      onChange={onChange}
    />
    <label htmlFor="toggler" className="label" />
  </span>
);

ToggleSwitch.propTypes = {
  onChange: PropTypes.func.isRequired,
  checked: PropTypes.bool.isRequired
};

export default ToggleSwitch;
