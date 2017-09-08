// @flow
import { getState, addMessage, subscribe, unsubscribe } from "./store";

describe("store", () => {
  const message = { body: "I'm a new message" };

  it("returns initial state", () => {
    expect(getState()).toEqual([]);
  });

  it("can add a message", () => {
    expect(getState()).toEqual([]);
    addMessage(message);
    expect(getState()[0]["body"]).toEqual(message.body);
  });

  it("can manage listeners", () => {
    const listener = jest.fn();
    subscribe(listener);
    addMessage(message);

    expect(listener.mock.calls.length).toEqual(1);

    unsubscribe(listener);
    addMessage({ body: "Second message" });

    expect(listener.mock.calls.length).toEqual(1);
    expect(getState().length).toEqual(3);
  });
});
