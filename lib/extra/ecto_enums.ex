import EctoEnum

defenum ProviderEnum, shopify: 0

# Used for timeslot recurrence column.
# Days match to `Date.day_of_week(%{})` output.
# everyday is 0 (and default column value)
# weekdays are 9
# weekends are 10
defenum Extra.RecurrenceEnum, everyday: 0, monday: 1, tuesday: 2, wednesday: 3,
                              thursday: 4, friday: 5, saturday: 6, sunday: 7,
                              weekdays: 9, weekends: 10
