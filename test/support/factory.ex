defmodule Extra.Factory do
  @moduledoc """
  Factories for creating test data and associations.
  """

  use ExMachina.Ecto, repo: Extra.Repo

  def user_factory do
    %Extra.User{
      full_name: "Kim Jansen",
      email: sequence(:email, &"kim-#{&1}@testusers.com"),
      password: "some long password string"
    }
  end

  def authorization_factory do
    %Extra.Authorization{
      expires_at: 42,
      provider: "twitter",
      refresh_token: "some content",
      token: "some content",
      uid: "some content"
    }
  end

  def post_collection_factory do
    %Extra.PostCollection{
      name: "some content"
    }
  end

  def post_content_factory do
    %Extra.PostContent{
      body: "some content",
      collection: build(:post_collection)
    }
  end

  def social_channel_factory do
    %Extra.SocialChannel{
      name: sequence(:name, &"Social Media Account ##{&1}"),
      provider: "Twitter",
      image: "https://an.image.url/picture.jpg"
    }
  end

  def with_channels(user) do
    insert_pair(:social_channel, user: user)
    user
  end

  def post_template_factory do
    %Extra.PostTemplate{}
  end

  def with_template_for(post_content, social_channel) do
    insert(:post_template, post_content: post_content, social_channel: social_channel)
    post_content
  end

  def schedule_factory do
    %Extra.Schedule {
      autopilot: true,
      channel: build(:social_channel)
    }
  end

  def timeslot_factory do
    %Extra.Timeslot {
      time: ~T[09:30:00],
      recurrence: Extra.RecurrenceEnum.__enum_map__[:everyday],
      schedule: build(:schedule),
      collection: build(:post_collection)
    }
  end

  def queued_post_factory do
    %Extra.QueuedPost {
      scheduled_for: Timex.shift(DateTime.utc_now(), hours: 1),
      timeslot: build(:timeslot)
    }
  end

  @spec insert_channel_resources() :: %{
    user: %Extra.User{}, channel: %Extra.SocialChannel{},
    schedule: %Extra.Schedule{}, collection: %Extra.PostCollection{}
  }
  def insert_channel_resources do
    user = insert(:user)
    channel = insert(:social_channel, user: user)
    schedule = insert(:schedule, channel: channel)
    collection = insert(:post_collection, user: user)

    %{
      user: user,
      channel: channel,
      schedule: schedule,
      collection: collection
    }
  end
end
