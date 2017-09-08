export function whichTransitionEvent() {
  const el = document.createElement("fakeelement");
  const transitions = {
    transition: "transitionend",
    OTransition: "oTransitionEnd",
    MozTransition: "transitionend",
    WebkitTransition: "webkitTransitionEnd"
  };

  return Object.keys(transitions).find(t => el.style[t] !== undefined);
}

export function whichAnimationEvent() {
  const transitionEvent = whichTransitionEvent();
  return transitionEvent && transitionEvent.replace("transition", "animation");
}
