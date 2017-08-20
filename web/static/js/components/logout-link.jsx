// @flow
import React from "react";
import type { Node } from "react";
import getCsrfToken from "../lib/csrfToken";

import LinkButton from "./ui/link-button";

export default ({ children }: { children: Node }) =>
  <form onSubmit={setCSRFToken} action="/logout" method="post">
    <input name="_method" type="hidden" value="delete" />
    <input name="_csrf_token" type="hidden" />
    <LinkButton className="sidebar-link">
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
