// @flow

export function collectionSelectOptions(collections: Array<Extra$PostCollection>) {
  return collections.reduce(
    (options, { id, name }) => [
      ...options,
      { value: id, label: name }
    ],
    [] // initial value
  );
}

export function channelMultiSelectOptions(channels: Array<Extra$Channel>) {
  return channels.reduce(
    (options, { id, name, provider }) => [
      ...options,
      { value: id, label: name, provider }
    ],
    [] // initial value
  );
}

export type PostContentFormData = {
  inputs: {
    content: {
      label: string,
      value: string
    },
    channels: {
      label: string,
      options: Array<{ value: string, label: string, provider: string }>,
      value: {}
    }
  },
  isSaving: boolean
};

export default function postContentForm(
  channels: Array<Extra$Channel> = []
): PostContentFormData {
  return {
    inputs: {
      content: {
        label: "Content",
        value: ""
      },
      channels: {
        label: "Channels",
        options: channelMultiSelectOptions(channels),
        value: {}
      }
    },
    isSaving: false
  };
}

export function updateInput(
  field: string, value: string | {}, form: PostContentFormData
): PostContentFormData {
  return {
    ...form,
    inputs: {
      ...form.inputs,
      [field]: {
        ...form.inputs[field],
        value
      }
    }
  };
}
