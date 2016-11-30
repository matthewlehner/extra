const VALUE_MISSING = "VALUE_MISSING";
const TYPE_MISMATCH = "TYPE_MISMATCH";
const TOO_SHORT = "TOO_SHORT";

function getErrorType(validityState) {
  if (validityState.valueMissing) { return VALUE_MISSING; }
  if (validityState.typeMismatch) { return TYPE_MISMATCH; }
  if (validityState.patternMismatch) { return TYPE_MISMATCH; }
  if (validityState.tooShort) { return TOO_SHORT; }
}

export default function messageFor(validityState, inputType) {
  const errorType = getErrorType(validityState);

  switch (inputType) {
    case "email":
      return emailErrorFor(errorType);
    case "password":
      return passwordErrorFor(errorType);
    default:
      return defaultErrorFor(errorType);
  }
}

function emailErrorFor(errorType) {
  switch(errorType) {
    case VALUE_MISSING:
      return "Please enter your email address.";
    case TYPE_MISMATCH:
      return "The email address you have entered is not valid.";
    default:
      return defaultErrorFor(errorType);
  }
}

function passwordErrorFor(errorType) {
  switch(errorType) {
    case VALUE_MISSING:
      return "Please enter a password.";
    case TOO_SHORT:
      return "The password must be at least 8 characters long.";
    default:
      return defaultErrorFor(errorType);
  }
}

function defaultErrorFor(errorType) {
  switch(errorType) {
    default:
      return "There is a problem with this field.";
  }
}
