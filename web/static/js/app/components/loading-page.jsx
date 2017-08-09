// @flow
import React from "react";

const style = {
  loadingPage: {
    position: "relative"
  },
  loadingTitle: {
    width: "15rem",
    height: "0.5rem",
    backgroundColor: "#EEEEEE",
    borderRadius: "0.5rem",
    position: "absolute",
    left: 0
  },
  loadingActions: {
    width: "7rem",
    height: "0.5rem",
    backgroundColor: "#EEEEEE",
    borderRadius: "0.5rem",
    position: "absolute",
    right: 0
  }
};

export default function LoadingPage({ isLoading, timedOut, pastDelay, error }) {
  if (isLoading) {
    // While our other component is loading...
    if (timedOut) {
      // In case we've timed out loading our other component.
      return <div>Loader timed out!</div>;
    } else if (pastDelay) {
      // Display a loading screen after a set delay.
      return (
        <div style={style.loadingPage}>
          <div style={style.loadingTitle} />
          <div style={style.loadingActions} />
        </div>
      );
    } else {
      // Don't flash "Loading..." when we don't need to.
      return null;
    }
  } else if (error) {
    // If we aren't loading, maybe
    return <div>Error! Component failed to load</div>;
  } else {
    // This case shouldn't happen... but we'll return null anyways.
    return null;
  }
}
