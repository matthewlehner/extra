defmodule Extra.Tweeter do
  @moduledoc """
  Functions for authenticating and publishing tweets.
  """

  def publish_status(%{content: status}, auth) do
    configure_extwitter(auth)

    ExTwitter.update(status)
  end

  def to_social_post_params(response) do
    %{
      content: response.text,
      channel_post_id: response.id_str,
      response: Map.from_struct(response),
      published_at: parse_timestamp(response.created_at)
    }
  end

  def parse_timestamp(timestamp) do
    [dow, mon, day, time, zone, year] = String.split(timestamp, " ")
    rfc1123 = Enum.join(["#{dow},", day, mon, year, time, zone], " ")

    Timex.parse!(rfc1123, "{RFC1123}")
  end

  defp configure_extwitter(auth) do
    config =
      :global
      |> ExTwitter.Config.get()
      |> Keyword.merge([access_token: auth.token,
                        access_token_secret: auth.secret])

    ExTwitter.configure(:process, config)
  end
end
