import React, { PropTypes } from "react";

const Select = ({ value, onChange, children }) => (
  <div className="select">
    <select value={value} onChange={onChange}>
      {children}
    </select>
  </div>
);

Select.propTypes = {
  value: PropTypes.oneOfType([PropTypes.string, PropTypes.number]),
  onChange: PropTypes.func.isRequired,
  children: PropTypes.node.isRequired
};

Select.defaultProps = {
  value: ""
};

export default Select;
