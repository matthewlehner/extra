let csrfToken: string;

function setCsrfToken() {
  const csrfMetaEl: ?HTMLElement = document.querySelector(
    "meta[name='csrf-token']"
  );
  if (csrfMetaEl && csrfMetaEl instanceof HTMLMetaElement) {
    csrfToken = csrfMetaEl.content;
  } else {
    csrfToken = "";
  }
}

export default function getCsrfToken() {
  if (!csrfToken) {
    setCsrfToken();
  }

  return csrfToken;
}
