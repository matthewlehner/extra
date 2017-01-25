defmodule Extra.LetsEncrypt do
  use Extra.Web, :controller

  @challenges %{
    "S0j7Rz2kbWbTaHR6SY6hrSTqOWKNNctVepC6XBUMz98" => "DhsZ1GNw2mYOe9pd5m-TgNHgZs14fd96qamEXxXTfvw",
    "ca1EiWo9x-UCtE4Lh9rBWy6NiyGdoIs929cwSFAV50U" => "DhsZ1GNw2mYOe9pd5m-TgNHgZs14fd96qamEXxXTfvw"
    "ENpwgAiE7J-0qmnl9rnMeaVImmOBy918Imbyh4e5skk" => "dTMmoG0_jpfxlLvva7qv2lww1-sE-AYxthComfBdjPc",
    "uFpFXftZmoX6ZQ6IEgrYBqMmpY-Uew-zHP75_djzX0Q" => "dTMmoG0_jpfxlLvva7qv2lww1-sE-AYxthComfBdjPc"
  }

  def verify(conn, %{"id" => challenge} = _params) do
    response = Map.fetch!(@challenges, challenge)
    text conn, "#{challenge}.#{response}"
  end
end
