//@flow
export type Notification = {|
  id: number,
  timestamp: Date,
  type: "info" | "error",
  body: string
|};

export type Notifications = Array<Notification>;

// Default state
let state: Notifications = [];
let listeners = [];

function getState(): Notifications {
  return state;
}

function setState(nextState: Notifications) {
  state = nextState;
  dispatch();
}

let id = 0;

type AddMessageArgs = {|
  body: string,
  type?: "info" | "error"
|};

function addMessage({ body, type }: AddMessageArgs): Notification {
  id++;

  const flash: Notification = {
    id,
    timestamp: new Date(),
    type: type || "info",
    body
  };

  setState([...state, flash]);

  setTimeout(() => {
    removeMessage(flash);
  }, 5000);

  return flash;
}

function removeMessage(flash) {
  const position = state.indexOf(flash);

  if (position !== -1) {
    setState([...state.slice(0, position), ...state.slice(position + 1)]);
  }
}

function subscribe(listener: Notifications => void): void {
  listeners.push(listener);
}

function unsubscribe(listener: () => void): void {
  listeners = listeners.filter(fn => fn !== listener);
}

function dispatch(): void {
  listeners.forEach(listener => listener(state));
}

export { getState, addMessage, subscribe, unsubscribe };
