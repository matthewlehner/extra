// @flow
import React from "react";
import { Helmet } from "react-helmet";

export default function DocumentHead({ title }: { title: string }) {
  return (
    <Helmet>
      <title>
        {title} | Extra
      </title>
    </Helmet>
  );
}

DocumentHead.defaultProps = {
  title: "Loading"
};
