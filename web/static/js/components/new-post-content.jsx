// @flow

import React from "react";
import { Link } from "react-router-dom";
import type { Match, RouterHistory } from "react-router-dom";

import Icon from "./icon";
import Modal from "./modal";

type NewPostContentProps = {
  match: Match,
  history: RouterHistory
};

const NewPostContent = (
  { match: { params }, history }: NewPostContentProps
) => {
  const cancelPath = `/collections/${params.id}`;
  const onCancel = () => history.push(cancelPath);

  return (
    <Modal title="Create new post" onClose={onCancel} cancelPath={cancelPath}>
      <form>
        <div className="form__control-group">
          <label
            className="form__control-label"
            htmlFor="post_content_post_collection_id"
          >
            Collection
          </label>
          <div className="select">
            <select
              className="form__control"
              id="post_content_post_collection_id"
              name="post_content[post_collection_id]"
              required="required"
            >
              <option value="1">Inspirational Posts</option>
            </select>
          </div>
        </div>
        <div className="form__control-group">
          <label className="form__control-label" htmlFor="post_content_body">
            Content
          </label>
          <textarea
            className="form__control"
            id="post_content_body"
            name="post_content[body]"
            required="required"
          />
        </div>

        <div className="form__control-group">
          <span className="form__control-label">Channel</span>
          <div className="form__collection-wrapper">
            <label htmlFor="post_content_templates_0_active">
              <input
                className="form__control"
                id="post_content_templates_0_active"
                name="post_content[templates][0][active]"
                type="checkbox"
                value="true"
              />
              <span className="form__indicator form__indicator_checkbox">
                <Icon className="icon icon_checkmark" name="checkmark" />
              </span>
              matthewpearse
            </label>
          </div>
        </div>

        <div className="form__actions">
          <Link className="button button_cancel" to={cancelPath}>
            Cancel
          </Link>
          <button className="button" type="submit">
            Create Post
          </button>
        </div>
      </form>
    </Modal>
  );
};

export default NewPostContent;
