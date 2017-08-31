defmodule Extra.TweeterTest do
  use ExUnit.Case, async: true
  alias Extra.Tweeter

  @published_tweet %ExTwitter.Model.Tweet{
    entities: %{hashtags: [], symbols: [], urls: [], user_mentions: []},
    coordinates: nil, current_user_retweet: nil, retweeted_status: nil,
    withheld_in_countries: nil, in_reply_to_status_id: nil,
    id: 903011006548385792, in_reply_to_user_id_str: nil, text: "I'm a tweet.",
    id_str: "903011006548385792", place: nil, display_text_range: nil,
    quoted_status: nil, truncated: false, favorite_count: 0,
    in_reply_to_status_id_str: nil, created_at: "Wed Aug 30 21:46:15 +0000 2017",
    scopes: nil, retweeted: false, geo: nil, contributors: nil,
    extended_entities: nil, full_text: nil, favorited: false,
    in_reply_to_user_id: nil,
    user: %ExTwitter.Model.User{
      entities: %{description: %{urls: []}},
      is_translator: false, verified: false, withheld_in_countries: nil,
      location: "", id: 902216106240331778, protected: true,
      id_str: "902216106240331778", listed_count: 0, is_translation_enabled: false,
      profile_text_color: "333333", default_profile: true,
      profile_image_url: "http://pbs.twimg.com/profile_images/902558068205993984/k2WBNu1L_normal.jpg",
      contributors_enabled: false, friends_count: 0, followers_count: 0,
      profile_sidebar_fill_color: "DDEEF6", url: nil, following: false,
      geo_enabled: false, follow_request_sent: false, screen_name: "ExtraAITest",
      default_profile_image: false, profile_background_color: "F5F8FA"},
    filter_level: nil, withheld_copyright: nil, quoted_status_id_str: nil,
    quoted_status_id: nil, retweet_count: 0, in_reply_to_screen_name: nil,
    source: "<a href=\"https://e0e1356a.ngrok.io\" rel=\"nofollow\">Extra Automation</a>",
    lang: "en", withheld_scope: nil, possibly_sensitive: nil
  }

  test ".parse_timestamp/1" do
    time = Timex.parse!("Wed, 30 Aug 2017 21:46:15 +0000", "{RFC1123}")

    assert time == Tweeter.parse_timestamp(@published_tweet.created_at)
  end

  test ".to_social_post_params/1" do
    params = Tweeter.to_social_post_params(@published_tweet)

    expected_params = %{
      content: @published_tweet.text,
      channel_post_id: @published_tweet.id_str,
      response: Map.from_struct(@published_tweet),
      published_at: Tweeter.parse_timestamp(@published_tweet.created_at)
    }

    assert params == expected_params
  end
end
