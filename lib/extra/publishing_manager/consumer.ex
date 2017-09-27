defmodule Extra.PublishingManager.Consumer do
  @moduledoc """
  Consumes the publishing queue and spawns tasks to do the post publishing.
  """

  use ConsumerSupervisor
  alias Extra.PublishingManager
  alias Extra.PublishingManager.Collector

  def start_link() do
    ConsumerSupervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(PublishingManager, [], restart: :temporary)
    ]

    {:ok, children, strategy: :one_for_one,
                    subscribe_to: [{Collector, max_demand: 5}]}
  end
end
