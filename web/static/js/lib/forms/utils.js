// @flow
export function handleChange(
  event: SyntheticEvent,
  field: string,
  callback: (field: string, value: string) => void
) {
  callback(field, event.currentTarget.value);
}
