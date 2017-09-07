defmodule Extra.PostPickerTest do
  use ExUnit.Case, async: true
end


# A channel's schedule needs to be built like this:
#
# Find a channel
# Get collections by timeslots,
#
# Group QueuedPosts by schedule_id and collection_id
# queued_posts = [
#   {:filled, queued_post},
#   {:filled, queued_post},
#   {:empty, queued_post},
#   {:empty, queued_post},
#   {:filled, queued_post},
#   {:filled, queued_post},
#   {:empty, queued_post},
#   {:filled, queued_post},
#   {:filled, queued_post},
# ]
#
# Get all schedules:
#
#     schedules =
#       from(s in Schedule,
#         join: ts in assoc(s, :timeslots),
#         preload: timeslots: ts)
#       |> Repo.all
#
#     [schedule | rest] = schedules
#
#     timeslots_for_collection =
#       from(ts in Timeslot,
#         where: [
#         collection_id: ^collection.id,
#         schedule_id: ^schedule.id
#         ])
#       |> Repo.all
#
#     timeslot_ids = Enum.map(timeslots_for_collection, &(&.id))
#     queued_posts =
#       from(qp in QueuedPost,
#         where: [
#         qp.timeslot_id in timeslot_ids
#         ])
#       |> Repo.all
