// @flow
import React from "react";
import renderer from "react-test-renderer";
import { mount } from "enzyme";

import ContentEditor, {
  validationSchema,
  mapPropsToValues,
  handleSubmit
} from "../../../components/forms/content-editor";

describe("<ContentEditor />", () => {
  const persistContent = jest.fn();
  const props = {
    channels: [],
    post: { body: "", channels: [] },
    collection: { name: "Name of a Collection" },
    persistContent: persistContent
  };

  it("renders without crashing", () => {
    const tree = renderer.create(<ContentEditor {...props} />);

    expect(tree).toMatchSnapshot();
  });

  it("displays errors when present", () => {
    const wrapper = mount(<ContentEditor {...props} />);
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
  test("submits the form", async () => {
    const values = {
      body: "body text",
      channels: { "1": true }
    };

    const resolve = jest.fn((resolve, reject) => resolve("response"));
    const persistContent = jest.fn(() => new Promise(resolve));
    const handleCancel = jest.fn();
    const setErrors = jest.fn();
    const setSubmitting = jest.fn();

    const props = {
      persistContent,
      handleCancel
    };

    const formikBag = { props, setErrors, setSubmitting };

    await handleSubmit(values, formikBag);

    expect(persistContent.mock.calls[0][0]).toEqual({
      body: "body text",
      channelIds: ["1"]
    });
    expect(resolve.mock.calls.length).toEqual(1);
    expect(setSubmitting.mock.calls.length).toEqual(1);
    expect(handleCancel.mock.calls.length).toEqual(1);
  });

  test("handles errors", async () => {
    const values = {
      body: "body text",
      channels: { "1": true }
    };

    const errorObject = { body: "not good" };

    const resolve = jest.fn((resolve, reject) => reject(errorObject));
    const persistContent = jest.fn(() => new Promise(resolve));
    const handleCancel = jest.fn();
    const setErrors = jest.fn();
    const setSubmitting = jest.fn();

    const props = { persistContent, handleCancel };

    const formikBag = { props, setErrors, setSubmitting };

    await handleSubmit(values, formikBag);

    expect(persistContent.mock.calls[0][0]).toEqual({
      body: "body text",
      channelIds: ["1"]
    });
    expect(resolve.mock.calls.length).toEqual(1);
    expect(setSubmitting.mock.calls.length).toEqual(1);
    expect(handleCancel.mock.calls.length).toEqual(0);
    expect(setErrors.mock.calls[0][0]).toEqual(errorObject);
  });
});
