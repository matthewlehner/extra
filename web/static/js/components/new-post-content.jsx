// @flow
import React, { Component } from "react";
import type { NewPostContentProps } from "../app/pages/new-post-content";

import postContentFormData, { updateInput } from "lib/new-post-content-form";
import type { PostContentFormData } from "lib/new-post-content-form";

import Modal from "./modal";
import PostContentForm from "./forms/post-content";

export default class NewPostContent extends Component {
  props: NewPostContentProps;

  state: {
    formData: PostContentFormData
  };

  constructor(props: NewPostContentProps) {
    super(props);
    const { channels } = props.data;
    this.state = { formData: postContentFormData(channels) };
  }

  componentWillReceiveProps(nextProps: NewPostContentProps) {
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
  };

  onCancel = (): void => {
    const { history, match: { params } } = this.props;
    history.push(`/collections/${params.id}`);
  };

  addPostContent = (): Promise<*> => {
    const { inputs, isSaving } = this.state.formData;
    const variables: AddPostContentMutationVariables = {
      body: inputs.content.value,
      collectionId: this.props.match.params.id,
      channelIds: Object.keys(inputs.channels.value).filter(
        id => inputs.channels.value[id]
      )
    };

    if (isSaving) {
      return Promise.resolve();
    }

    this.setState(({ formData }) => ({
      formData: {
        ...formData,
        isSaving: true
      }
    }));

    return this.props.addPostContent({ variables }).then(() => {
      this.onCancel();
    });
  };

  render() {
    const { data: { loading, error, collection } } = this.props;

    return (
      <Modal title="Create new post" onDismiss={this.onCancel}>
        {loading
          ? "Loading"
          : error
            ? error.message
            : <PostContentForm
                collection={collection}
                onChangeInput={this.onChangeInput}
                addPostContent={this.addPostContent}
                formData={this.state.formData}
                onCancel={this.onCancel}
              />}
      </Modal>
    );
  }
}
