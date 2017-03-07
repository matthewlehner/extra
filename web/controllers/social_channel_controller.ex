defmodule Extra.SocialChannelController do
  use Extra.Web, :controller

  alias Extra.SocialChannel

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def show(%{assigns: %{current_user: user}} =  conn, %{"id" => id}) do
    social_channel = Repo.get_by!(SocialChannel, id: id, user_id: user.id)
    schedule = Extra.PostingSchedule.for_channel

    render(conn, "show.html", social_channel: social_channel, schedule: schedule)
  end

  # def update(conn, %{"id" => id, "social_channel" => social_channel_params}) do
  #   social_channel = Repo.get!(SocialChannel, id)
  #   changeset = SocialChannel.changeset(social_channel, social_channel_params)
  #
  #   case Repo.update(changeset) do
  #     {:ok, social_channel} ->
  #       conn
  #       |> put_flash(:info, "Social channel updated successfully.")
  #       |> redirect(to: social_channel_path(conn, :show, social_channel))
  #     {:error, changeset} ->
  #       render(conn, "edit.html", social_channel: social_channel, changeset: changeset)
  #   end
  # end
  #
  # def delete(conn, %{"id" => id}) do
  #   social_channel = Repo.get!(SocialChannel, id)
  #
  #   # Here we use delete! (with a bang) because we expect
  #   # it to always work (and if it does not, it will raise).
  #   Repo.delete!(social_channel)
  #
  #   conn
  #   |> put_flash(:info, "Social channel deleted successfully.")
  #   |> redirect(to: social_channel_path(conn, :index))
  # end
end
