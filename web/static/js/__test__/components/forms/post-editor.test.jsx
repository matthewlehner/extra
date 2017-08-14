// @flow
import React from "react";
import renderer from "react-test-renderer";
import { mount } from "enzyme";

import PostEditor, {
  validationSchema,
  mapPropsToValues,
  handleSubmit
} from "../../../components/forms/post-editor";

describe("<PostEditor />", () => {
  const persistPost = jest.fn();
  const props = {
    channels: [],
    post: { body: "", channels: [] },
    collection: { name: "Name of a Collection" },
    persistPost: persistPost
  };

  it("renders without crashing", () => {
    const tree = renderer.create(<PostEditor {...props} />);

    expect(tree).toMatchSnapshot();
  });

  it("displays errors when present", () => {
    const wrapper = mount(<PostEditor {...props} />);
    wrapper.find("button[type='submit']").simulate("click");
  });
});

describe("validationSchema", () => {
  test("validates values", async () => {
    const value = {
      body: "hi",
      channels: { "1": true, "2": true }
    };
    const validation = await validationSchema.validate(value);
    expect(validation).toEqual(value);
  });

  test("returns error messages", async () => {
    expect.assertions(2);
    try {
      await validationSchema.validate({}, { abortEarly: false });
    } catch (e) {
      expect(e.name).toEqual("ValidationError");
      expect(e.errors).toEqual(["body is a required field"]);
    }
  });
});

describe("mapPropsToValues", () => {
  test("returns correct values", () => {
    const body = "body text";
    const props = {
      post: { body, channels: [{ id: "1" }, { id: "2" }] }
    };

    const output = mapPropsToValues(props);
    expect(output).toEqual({ body, channels: { "1": true, "2": true } });
  });
});

describe("handleSubmit", () => {
  test("submits the form", () => {
    const values = {
      body: "body text",
      channels: { "1": true }
    };

    const resolve = jest.fn();
    const reject = jest.fn();
    const persistPost = jest.fn(() => new Promise(resolve, reject));
    const handleCancel = jest.fn();
    const setErrors = jest.fn();
    const setSubmitting = jest.fn();

    const props = {
      persistPost,
      handleCancel,
      post: { id: 1 }
    };

    const formikBag = { props, setErrors, setSubmitting };

    handleSubmit(values, formikBag);

    expect(persistPost.mock.calls[0][0]).toEqual({
      variables: { input: { body: "body text", channelIds: ["1"], id: 1 } }
    });
    expect(resolve.mock.calls.length).toEqual(1);
    expect(setSubmitting.mock.calls.length).toEqual(1);
    expect(reject.mock.calls.length).toEqual(0);
  });
});
