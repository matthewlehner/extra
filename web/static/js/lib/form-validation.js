// on `focus` listen for `input`
// if `input` listen for `blur`
// on `blur` run validations
// validations should
//   - add `dirty` class to `.form-control`
//   - look for `.help-block` if not present, add error string.
import errorMessageFor from "./forms/error-messages";

const dirtyClass = "dirty";
const placeholderShownClass = "input-empty";
const helpMessage = {
  position: "beforebegin",
  tagName: "span",
  className: "help-block"
};

function isNotDirty(element) {
  // Check that it is an input
  return element.tagName === "INPUT" &&
  // Checks if parentNode is dirty
  !element.parentNode.classList.contains(dirtyClass);
}

function onInput(e) {
  const element = e.target;
  element.removeEventListener(e.type, onInput);
  element.addEventListener("blur", onActivateValidations);
}

function onActivateValidations(e) {
  const element = e.target;
  element.removeEventListener(e.type, activateValidations);
  activateValidations(element);
}

function activateValidations(element) {
  element.addEventListener("input", (e) => runValidations(e.target));
  element.parentNode.classList.add(dirtyClass);
  return runValidations(element);
}

function runValidations(element) {
  if (element.value.length > 0) {
    element.parentNode.classList.remove(placeholderShownClass);
  } else {
    element.parentNode.classList.add(placeholderShownClass);
  }

  return validateInput(element);
}

function errorElString(el) {
  const content = errorMessageFor(el.validity, el.type);
  const {tagName, className} = helpMessage;

  return `<${tagName} class="${className}">${content}</${tagName}>`;
}

function renderErrorForInput(el) {
  const errorMsg = errorElString(el);
  el.insertAdjacentHTML(helpMessage.position, errorMsg);
}

function findHelpEl(el) {
  switch (helpMessage.position) {
    case "beforebegin":
      return el.previousElementSibling;
    case "afterend":
      return el.nextElementSibling;
    default:
      throw "You must define `helpMessagePosition`";
  }
}

function validateInput(inputEl) {
  const helpEl = findHelpEl(inputEl);
  if (inputEl.checkValidity()) {
    removeHelpBlock(helpEl);
    return true;
  }

  if (isHelpEl(helpEl)) {
    helpEl.innerText = errorMessageFor(inputEl.validity, inputEl.type);
    return false;
  }

  renderErrorForInput(inputEl);
  return false;
}

function isHelpEl(el) {
  const { className, tagName } = helpMessage;

  if (el && el.tagName === tagName.toUpperCase() && el.classList.contains(className)) {
    return true;
  }

  return false;
}

function removeHelpBlock(el) {
  if (isHelpEl(el)) {
    el.parentNode.removeChild(el);
  }
}

window.addEventListener("focus", function(event) {
  if (isNotDirty(event.target)) {
    event.target.addEventListener("input", onInput);
    return false;
  }
}, true);

window.addEventListener("submit", function(event) {
  if (event.target.tagName !== "FORM") { return; }
  const inputs = [...event.target.getElementsByClassName("form-control")];
  const inputsValid = inputs.map(activateValidations).every((value) => value);

  if (inputsValid) {
    return;
  }

  event.preventDefault();
}, true);
