import { whichAnimationEvent } from "./which-transition-event";

const animationEndEvent = whichAnimationEvent();

export function animatedElementRemoval(el) {
  if (animationEndEvent) {
    el.classList.add("removing");
    el.addEventListener(
      animationEndEvent,
      () => el.parentNode.removeChild(el)
    );
    return;
  }

  el.parentNode.removeChild(el);
}

export function onDocumentReady(fn) {
  if (document.readyState !== "loading") {
    fn();
  }
  else {
    document.addEventListener("DOMContentLoaded", fn);
  }
}
