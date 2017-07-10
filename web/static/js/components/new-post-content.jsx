// @flow

import React, { Component } from "react";
import type { Match, RouterHistory } from "react-router-dom";

import postContentFormData, {
  updateInput
} from "lib/new-post-content-form";
import type { PostContentFormData } from "lib/new-post-content-form";

import Modal from "./modal";
import PostContentForm from "./forms/post-content";

type Props = {
  match: Match,
  history: RouterHistory,
  data: {
    loading: boolean,
    error?: {
      message: string
    },
    channels: Array<Extra$Channel>,
    collection: {
      id: string,
      name: string
    }
  },
  addPostContent: ({
    variables: {
      body: string, collectionId: string, channelIds: Array<string>
    }
  }) => Promise<*>
};

export default class NewPostContent extends Component {
  props: Props

  state: {
    formData: PostContentFormData
  }

  constructor(props: Props) {
    super(props);

    const { channels } = props.data;

    this.state = { formData: postContentFormData(channels) };
  }

  componentWillReceiveProps(nextProps: Props) {
    const { channels } = nextProps.data;

    if (this.props.data.channels !== channels) {
      this.setState(() => ({
        formData: postContentFormData(channels)
      }));
    }
  }

  onChangeInput = (field: string, value: string | {}): void => {
    this.setState(({ formData }) => ({
      formData: updateInput(field, value, formData)
    }));
  }

  onCancel = (): void => {
    const { history, match: { params } } = this.props;
    history.push(`/collections/${params.id}`);
  }

  addPostContent = (): Promise<*> => {
    const { inputs, isSaving } = this.state.formData;
    const variables : {
      body: string,
      collectionId: string,
      channelIds: Array<string>
    } = {
      body: inputs.content.value,
      collectionId: this.props.match.params.id,
      channelIds: Object.keys(inputs.channels.value).filter(id => inputs.channels.value[id])
    };

    if (isSaving) { return Promise.resolve(); }

    this.setState(({ formData }) => ({
      formData: {
        ...formData,
        isSaving: true
      }
    }));

    return this.props.addPostContent({ variables })
      .then(() => {
        this.onCancel();
      });
  }

  render() {
    const { data: { loading, error, collection } } = this.props;

    return (
      <Modal title="Create new post" onDismiss={this.onCancel}>
        {
          loading || error
          ? "Loading"
          : <PostContentForm
            collection={collection}
            onChangeInput={this.onChangeInput}
            addPostContent={this.addPostContent}
            formData={this.state.formData}
            onCancel={this.onCancel}
          />
        }
      </Modal>
    );
  }
}
