// @flow

import React from "react";

type ToggleSwitchProps = {
  checked: boolean,
  onChange: Function
};

const ToggleSwitch = ({ checked, onChange }: ToggleSwitchProps) => (
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

export default ToggleSwitch;
