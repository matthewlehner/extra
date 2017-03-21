export const dayTranslations = {
  MONDAY: "Monday",
  TUESDAY: "Tuesday",
  WEDNESDAY: "Wednesday",
  THURSDAY: "Thursday",
  FRIDAY: "Friday",
  SATURDAY: "Saturday",
  SUNDAY: "Sunday",
  WEEKENDS: "Weekends",
  WEEKDAYS: "Weekdays",
  EVERYDAY: "Everyday"
};

const weekends = ["Saturday", "Sunday"];
const weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];
export const daysOfTheWeek = [...weekdays, ...weekends];

export function shouldAppearOnDay(recurrence, day) {
  switch (recurrence) {
    case "EVERYDAY": return true;
    case "WEEKENDS": return weekends.includes(day);
    case "WEEKDAYS": return weekdays.includes(day);
    default: return recurrence === day.toUpperCase();
  }
}

export function timeslotsFor(day, timeslots) {
  return timeslots.filter(({ recurrence }) =>
    shouldAppearOnDay(recurrence, day)
  );
}
