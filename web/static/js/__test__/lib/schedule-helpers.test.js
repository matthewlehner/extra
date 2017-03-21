import { shouldAppearOnDay, timeslotsFor } from "lib/schedule-helpers";

describe("shouldAppearOnDay", () => {
  it("is always true for \"EVERYDAY\"", () => {
    expect(shouldAppearOnDay("EVERYDAY", "Monday")).toBeTruthy();
    expect(shouldAppearOnDay("EVERYDAY", "Tuesday")).toBeTruthy();
    expect(shouldAppearOnDay("EVERYDAY", "Wednesday")).toBeTruthy();
    expect(shouldAppearOnDay("EVERYDAY", "Thursday")).toBeTruthy();
    expect(shouldAppearOnDay("EVERYDAY", "Friday")).toBeTruthy();
    expect(shouldAppearOnDay("EVERYDAY", "Saturday")).toBeTruthy();
    expect(shouldAppearOnDay("EVERYDAY", "Sunday")).toBeTruthy();
  });

  it("knows \"WEEKENDS\"", () => {
    expect(shouldAppearOnDay("WEEKENDS", "Monday")).toBeFalsy();
    expect(shouldAppearOnDay("WEEKENDS", "Tuesday")).toBeFalsy();
    expect(shouldAppearOnDay("WEEKENDS", "Wednesday")).toBeFalsy();
    expect(shouldAppearOnDay("WEEKENDS", "Thursday")).toBeFalsy();
    expect(shouldAppearOnDay("WEEKENDS", "Friday")).toBeFalsy();
    expect(shouldAppearOnDay("WEEKENDS", "Saturday")).toBeTruthy();
    expect(shouldAppearOnDay("WEEKENDS", "Sunday")).toBeTruthy();
  });

  it("knows \"WEEKDAYS\"", () => {
    expect(shouldAppearOnDay("WEEKDAYS", "Monday")).toBeTruthy();
    expect(shouldAppearOnDay("WEEKDAYS", "Tuesday")).toBeTruthy();
    expect(shouldAppearOnDay("WEEKDAYS", "Wednesday")).toBeTruthy();
    expect(shouldAppearOnDay("WEEKDAYS", "Thursday")).toBeTruthy();
    expect(shouldAppearOnDay("WEEKDAYS", "Friday")).toBeTruthy();
    expect(shouldAppearOnDay("WEEKDAYS", "Saturday")).toBeFalsy();
    expect(shouldAppearOnDay("WEEKDAYS", "Sunday")).toBeFalsy();
  });

  it("does invididual days too", () => {
    expect(shouldAppearOnDay("MONDAY", "Monday")).toBeTruthy();
    expect(shouldAppearOnDay("TUESDAY", "Tuesday")).toBeTruthy();
    expect(shouldAppearOnDay("WEDNESDAY", "Wednesday")).toBeTruthy();
    expect(shouldAppearOnDay("THURSDAY", "Thursday")).toBeTruthy();
    expect(shouldAppearOnDay("FRIDAY", "Friday")).toBeTruthy();
    expect(shouldAppearOnDay("SATURDAY", "Saturday")).toBeTruthy();
    expect(shouldAppearOnDay("SUNDAY", "Sunday")).toBeTruthy();
  });
});
