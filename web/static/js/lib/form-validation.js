// on `focus` listen for `input`
// if `input` listen for `blur`
// on `blur` run validations
// validations should
//   - add `dirty` class to `.form-control`
//   - look for `.help-block` if not present, add error string.
import errorMessageFor from "./forms/error-messages";

const dirtyClass = "dirty";
const placeholderShownClass = "input-empty";

function isNotDirty(element) {
  // Check that it is an input
  return element.tagName === "INPUT" &&
  // Checks if parentNode is dirty
  !element.parentNode.classList.contains(dirtyClass);
}

function onInput(e) {
  const element = e.target;
  element.removeEventListener(e.type, onInput);
  element.addEventListener("blur", activateValidations);
}

function activateValidations(e) {
  const element = e.target;
  element.removeEventListener(e.type, activateValidations);
  element.parentNode.classList.add(dirtyClass);
  runValidations(e);
  element.addEventListener("input", runValidations);
}

function runValidations(e) {
  const element = e.target;
  validateInput(element);

  if (element.value.length > 0) {
    element.parentNode.classList.remove(placeholderShownClass);
    return;
  }

  element.parentNode.classList.add(placeholderShownClass);
}

function errorElString(el) {
  const content = errorMessageFor(el.validity, el.type);

  return `<span class="help-block">${content}</span>`;
}

function displayError(el) {
  const errorMsg = errorElString(el);
  el.insertAdjacentHTML("afterend", errorMsg);
}

function validateInput(el) {
  const sibling = el.nextElementSibling;
  if (el.checkValidity()) {
    removeHelpBlock(el.nextElementSibling);
    return;
  }

  if (isErrorEl(sibling)) {
    sibling.innerText = errorMessageFor(el.validity, el.type);
    return;
  }

  displayError(el);
}

function isErrorEl(el) {
  return el.tagName === "SPAN" && el.classList.contains("help-block");
}

function removeHelpBlock(el) {
  if (isErrorEl(el)) el.parentNode.removeChild(el);
}

window.addEventListener("focus", function(event) {
  if (isNotDirty(event.target)) {
    event.target.addEventListener("input", onInput);
    return false;
  }
}, true);
