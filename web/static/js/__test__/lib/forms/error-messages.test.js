import messageFor from "lib/forms/error-messages";

describe("email validations", () => {
  test("on valueMissing", () => {
    expect(messageFor({ valueMissing: true }, "email"))
      .toBe("Please enter your email address.");
  });

  test("on typeMismatch", () => {
    expect(messageFor({ typeMismatch: true }, "email"))
      .toBe("The email address you have entered is not valid.");
  });
});
