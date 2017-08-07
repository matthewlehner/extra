defmodule Extra.SchedulerSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    server? = Phoenix.Endpoint.server?(:extra, Extra.Endpoint)
    children = registry(server?)

    supervise(children, strategy: :one_for_one)
  end

  defp registry(server?) do
    if server? do
      [worker(Extra.SchedulerRegistry, [Extra.SchedulerRegistry])]
    else
      []
    end
  end
end
