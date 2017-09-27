defmodule Extra.PublishingManager.Supervisor do
  @moduledoc "Supervisor that starts the publishing GenStage stuff."

  use Supervisor
  alias Extra.PublishingManager.Collector
  alias Extra.PublishingManager.Consumer

  def start_link() do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(Collector, []),
      worker(Consumer, [], id: 1)
    ]

    {:ok, children, strategy: :one_for_one}
  end
end
