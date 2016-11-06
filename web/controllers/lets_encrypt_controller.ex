defmodule Extra.LetsEncrypt do
  use Extra.Web, :controller

  @challenges %{
    "S0j7Rz2kbWbTaHR6SY6hrSTqOWKNNctVepC6XBUMz98" => "DhsZ1GNw2mYOe9pd5m-TgNHgZs14fd96qamEXxXTfvw",
    "KTls2I5JbcCn8Lxpv-aoeSG43YpAZTV6wbQqoaIoul8" => "DhsZ1GNw2mYOe9pd5m-TgNHgZs14fd96qamEXxXTfvw"
  }

  def verify(conn, %{"id" => challenge} = _params) do
    response = Map.fetch!(@challenges, challenge)
    text conn, "#{challenge}.#{response}"
  end
end
