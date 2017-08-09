// @flow
import React from "react";

export default function LoadingSidebar(props) {
  return (
    <nav className="site-nav">
      <section>
        <div style={styles.header} />
        <div style={styles.bullet} />
        <div style={styles.listItem} />
        <div style={styles.bullet} />
        <div style={styles.listItemAlt} />
        <div style={styles.bullet} />
        <div style={styles.listItem} />
      </section>
      <section>
        <div style={styles.header} />
        <div style={styles.bullet} />
        <div style={styles.listItem} />
        <div style={styles.bullet} />
        <div style={styles.listItemAlt} />
        <div style={styles.bullet} />
        <div style={styles.listItem} />
      </section>
      <section>
        <div style={styles.header} />
        <div style={styles.bullet} />
        <div style={styles.listItem} />
        <div style={styles.bullet} />
        <div style={styles.listItemAlt} />
        <div style={styles.bullet} />
        <div style={styles.listItem} />
      </section>
    </nav>
  );
}

const styles = {};

styles.header = {
  width: "5.375rem",
  height: "0.5rem",
  backgroundColor: "rgba(118, 101, 207, 72)",
  borderRadius: "0.5rem",
  marginBottom: "0.625rem"
};

styles.listItem = {
  ...styles.header,
  width: "7.5rem",
  marginLeft: "0.875rem",
  backgroundColor: "rgba(157, 143, 233, 85)"
};

styles.listItemAlt = {
  ...styles.listItem,
  width: "5rem"
};

styles.bullet = {
  ...styles.listItem,
  float: "left",
  width: "0.5rem",
  marginLeft: "0"
};
