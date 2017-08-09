//@flow
export type FlashMessage = {|
  timestamp: Date,
  message: string
|};

// Default state
let state: Array<FlashMessage> = [];
let listeners = [];

function getState() {
  return state;
}

function addMessage(message: string): void {
  const flash: FlashMessage = { timestamp: new Date(), message };
  state = [...state, flash];
  dispatch();
}

function subscribe(listener: () => void): void {
  listeners.push(listener);
}

function unsubscribe(listener: () => void): void {
  listeners = listeners.filter(fn => fn !== listener);
}

function dispatch(): void {
  listeners.forEach(listener => listener(state));
}

export { getState, addMessage, subscribe, unsubscribe };
