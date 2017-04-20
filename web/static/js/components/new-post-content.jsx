// @flow

import React from "react";
import { Link } from "react-router-dom";
import type { Match, RouterHistory } from "react-router-dom";

type NewPostContentProps = {
  match: Match,
  history: RouterHistory
};

function handleClick(event:MouseEvent, history:RouterHistory, path:string) {
  if (event.currentTarget !== event.target) return;
  history.push(path);
}

const NewPostContent = ({ match: { params }, history }: NewPostContentProps) => {
  const cancelPath = `/collections/${params.id}`;

  return (
    /*  eslint-disable jsx-a11y/no-static-element-interactions */
    <div className="modal__overlay" onClick={event => handleClick(event, history, cancelPath)}>
      <div className="modal__container">
        <header className="modal__header">
          <Link className="modal__dismiss" to={cancelPath}>
            &times;
          </Link>
          <h2>Create new post</h2>
        </header>
        <div className="modal__body">
          <form>
            <div className="form__control-group">
              <label className="form__control-label" htmlFor="post_content_post_collection_id">Collection</label>
              <div className="select">
                <select className="form__control" id="post_content_post_collection_id" name="post_content[post_collection_id]" required="required">
                  <option value="1">Inspirational Posts</option>
                </select>
              </div>
            </div>
            <div className="form__control-group">
              <label className="form__control-label" htmlFor="post_content_body">Content</label>
              <textarea className="form__control" id="post_content_body" name="post_content[body]" required="required" />
            </div>

            <div className="form__control-group">
              <span className="form__control-label">Channel</span>
              <div className="form__collection-wrapper">
                <label htmlFor="post_content_templates_0_active">
                  <input className="form__control" id="post_content_templates_0_active" name="post_content[templates][0][active]" type="checkbox" value="true" />
                  <span className="form__indicator form__indicator_checkbox">
                    <svg className="icon icon_checkmark"><use xlinkHref="/images/app.svg#checkmark-icon" /></svg>
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
        </div>
      </div>
    </div>
  );
};

export default NewPostContent;
