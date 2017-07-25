// @flow
import React, { PureComponent } from "react";
import Icon from "../../components/icon";
import ChannelLogo from "../../components/channel-logo";

type Props = {
  options: Array<{ id: string, name: string, provider: string }>,
  name: string,
  onChange: (string, {}) => void,
  value: {}
};

export default class ChannelSelector extends PureComponent {
  props: Props;

  defaultProps = {
    options: []
  };

  constructor(props: Props) {
    super(props);

    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(event: SyntheticEvent): void {
    const { onChange, name, value: checkboxValues } = this.props;
    const { value, checked } = event.currentTarget;
    const newValue = { ...checkboxValues, [value]: checked };
    onChange(name, newValue);
  }

  render() {
    const { options, name, value: checkboxValues } = this.props;
    return (
      <div className="form__collection-wrapper">
        {options.map(({ id: value, name: label, provider }) =>
          <label
            key={value}
            htmlFor={`${name}-${value}`}
            style={{ position: "relative" }}
          >
            <input
              className="form__control"
              type="checkbox"
              id={`${name}-${value}`}
              value={value}
              checked={checkboxValues[value] || false}
              onChange={this.handleChange}
            />
            <span className="form__indicator form__indicator_checkbox">
              <Icon className="icon icon_checkmark" name="checkmark" />
            </span>
            <ChannelLogo provider={provider} />
            {label}
          </label>
        )}
      </div>
    );
  }
}
