import {
  animatedElementRemoval,
  onDocumentReady
} from "./dom-utils";

const flashMessageClass = "flash_message";

function isFlashMessage(element) {
  return element.classList.contains(flashMessageClass);
}

function removeFlashMessages() {
  const flashEls = document.getElementsByClassName(flashMessageClass);

  setTimeout(() => {
    [...flashEls].forEach(animatedElementRemoval);
  }, 10000);
}

window.addEventListener("click", (event) => {
  // Checks if the target is a flash message
  if (event.target && isFlashMessage(event.target)) {
    // Checks if it's being removed
    if (!event.target.classList.contains("removing")) {
      animatedElementRemoval(event.target);
    }
    event.preventDefault();
  }
}, false);

document.addEventListener("turbolinks:load", removeFlashMessages);
onDocumentReady(removeFlashMessages);
