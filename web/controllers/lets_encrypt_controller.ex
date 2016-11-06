defmodule Extra.LetsEncrypt do
  use Extra.Web, :controller

  @challenges %{
    "S0j7Rz2kbWbTaHR6SY6hrSTqOWKNNctVepC6XBUMz98" => "DhsZ1GNw2mYOe9pd5m-TgNHgZs14fd96qamEXxXTfvw",
    "ca1EiWo9x-UCtE4Lh9rBWy6NiyGdoIs929cwSFAV50U" => "DhsZ1GNw2mYOe9pd5m-TgNHgZs14fd96qamEXxXTfvw"
  }

  def verify(conn, %{"id" => challenge} = _params) do
    response = Map.fetch!(@challenges, challenge)
    text conn, "#{challenge}.#{response}"
  end
end
