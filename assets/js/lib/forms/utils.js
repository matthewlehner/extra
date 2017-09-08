// @flow
export function handleChange(
  event: SyntheticInputEvent,
  field: string,
  callback: (field: string, value: string) => void
) {
  if (typeof event.currentTarget.value === "string") {
    callback(field, event.currentTarget.value);
  }
}
