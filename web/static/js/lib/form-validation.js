// on `focus` listen for `input`
// if `input` listen for `blur`
// on `blur` run validations
// validations should
//   - add `dirty` class to `.form-control`
//   - look for `.help-block` if not present, add error string.
import errorMessageFor from "./forms/error-messages";
import { animatedElementRemoval } from "./dom-utils";

const inputClass = "form__control";
const dirtyClass = "dirty";
const helpMessage = {
  position: "afterend",
  tagName: "div",
  className: "help-block"
};

function isNotDirty(element) {
  // Check that it is an input
  return element.tagName === "INPUT" &&
  // Checks if parentNode is dirty
  !element.parentNode.classList.contains(dirtyClass);
}

function findHelpEl(el) {
  switch (helpMessage.position) {
    case "beforebegin":
      return el.previousElementSibling;
    case "afterend":
      return el.nextElementSibling;
    default:
      throw new Error("You must define `helpMessage.position`");
  }
}

function isHelpEl(el) {
  const { className, tagName } = helpMessage;

  if (
    // Element exists
    el &&
      // It is a help message tag
      el.tagName === tagName.toUpperCase() &&
      // It has the help message class name
      el.classList.contains(className) &&
      // It is not being removed.
      !el.classList.contains("removing")
  ) {
    return true;
  }

  return false;
}

function removeHelpBlock(el) {
  if (isHelpEl(el)) {
    animatedElementRemoval(el);
  }
}

function errorElString(el) {
  const content = errorMessageFor(el.validity, el.type);
  const { tagName, className } = helpMessage;

  return `<${tagName} class="${className}"><span>${content}</span></${tagName}>`;
}

function renderErrorForInput(el) {
  const errorMsg = errorElString(el);
  el.insertAdjacentHTML(helpMessage.position, errorMsg);
}

function validateInput(inputEl) {
  const helpEl = findHelpEl(inputEl);
  if (inputEl.checkValidity()) {
    removeHelpBlock(helpEl);
    return true;
  }

  if (isHelpEl(helpEl)) {
    helpEl.children[0].innerText = errorMessageFor(inputEl.validity, inputEl.type);
    return false;
  }

  renderErrorForInput(inputEl);
  return false;
}

function activateValidations(element) {
  element.addEventListener("input", e => validateInput(e.target));
  element.parentNode.classList.add(dirtyClass);
  return validateInput(element);
}

function onActivateValidations(e) {
  const element = e.target;
  element.removeEventListener(e.type, activateValidations);
  activateValidations(element);
}

function onInput(e) {
  const element = e.target;
  element.removeEventListener(e.type, onInput);
  element.addEventListener("blur", onActivateValidations);
}

window.addEventListener("focus", (event) => {
  if (isNotDirty(event.target)) {
    event.target.addEventListener("input", onInput);
    return false;
  }
  return event;
}, true);

window.addEventListener("submit", (event) => {
  if (event.target.tagName !== "FORM") { return; }
  const inputs = [...event.target.getElementsByClassName(inputClass)];
  const inputsValid = inputs.map(activateValidations).every(value => value);

  if (inputsValid) {
    return;
  }

  event.preventDefault();
}, true);
