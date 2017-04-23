// @flow

export function collectionSelectOptions(collections: Array<PostCollection>) {
  return collections.reduce(
    (options, { id, name }) => [
      ...options,
      { value: id, label: name }
    ],
    [] // initial value
  );
}

export function channelMultiSelectOptions(channels: Array<Channel>) {
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
    collection: {
      label: string,
      options: Array<{ value: string, label: string }>,
      value: null | string
    },
    content: {
      label: string,
      value: null | string
    },
    channels: {
      label: string,
      options: Array<{ value: string, label: string, provider: string }>,
      value: {} | null
    }
  }
};

export default function postContentForm(
  collections:Array<PostCollection>,
  channels:Array<Channel>
): PostContentFormData {
  return {
    inputs: {
      collection: {
        label: "Collection",
        options: collectionSelectOptions(collections),
        value: null
      },
      content: {
        label: "Content",
        value: ""
      },
      channels: {
        label: "Channels",
        options: channelMultiSelectOptions(channels),
        value: {}
      }
    }
  };
}

export function updateInput(
  field: string, value:string | {}, form:PostContentFormData
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
