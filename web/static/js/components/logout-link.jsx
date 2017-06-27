// @flow
import React from "react";
import type { Children } from "react";
import getCsrfToken from "../lib/csrfToken";

import LinkButton from "./ui/link-button";

const linkColor = "rgba(255, 255, 255, 0.8)";

export default ({ children }: Children) =>
  <form onSubmit={setCSRFToken} action="/logout" method="post">
    <input name="_method" type="hidden" value="delete" />
    <input name="_csrf_token" type="hidden" />
    <LinkButton style={{ color: linkColor, fill: linkColor }}>
      {children}
    </LinkButton>
  </form>;

function setCSRFToken(event: SyntheticEvent) {
  const formEl = event.target;

  if (formEl && formEl instanceof HTMLFormElement) {
    const tokenInput = formEl.elements.namedItem("_csrf_token");

    if (tokenInput && tokenInput instanceof HTMLInputElement) {
      tokenInput.value = getCsrfToken();
    }
  }
}
