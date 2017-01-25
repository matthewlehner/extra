defmodule Extra.LetsEncrypt do
  use Extra.Web, :controller

  @challenges %{
    "S0j7Rz2kbWbTaHR6SY6hrSTqOWKNNctVepC6XBUMz98" => "DhsZ1GNw2mYOe9pd5m-TgNHgZs14fd96qamEXxXTfvw",
    "ca1EiWo9x-UCtE4Lh9rBWy6NiyGdoIs929cwSFAV50U" => "DhsZ1GNw2mYOe9pd5m-TgNHgZs14fd96qamEXxXTfvw",
    "HiSdFFk8dBQllSJjRcjFBAQ4RGCuekLFFt88o48cDXM" => "dTMmoG0_jpfxlLvva7qv2lww1-sE-AYxthComfBdjPc",
    "P5H0lGtzs92N1-LoiE38PrdRKXLnT_NsGdvBscocOqI" => "dTMmoG0_jpfxlLvva7qv2lww1-sE-AYxthComfBdjPc"
  }

  def verify(conn, %{"id" => challenge} = _params) do
    response = Map.fetch!(@challenges, challenge)
    text conn, "#{challenge}.#{response}"
  end
end
