export function handleChange(
  event:Event,
  field:string,
  callback: (field: string, value:string) => void
) {
  callback(field, event.currentTarget.value);
}

