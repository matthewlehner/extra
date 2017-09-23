defmodule Extra.Queue do
  @moduledoc "Elixir wrapper around Erlang's :queue"

  def enqueue(queue, item), do: :queue.in(item, queue)

  def take(queue, n) do
    {q1, q2} = split(queue, n)
    {to_list(q1), q2}
  end

  def pop(queue) do
    case :queue.out(queue) do
      {{:value, item}, new_queue} -> {item, new_queue}
      {:empty, new_queue} -> {nil, new_queue}
    end
  end

  def split(queue, n) do
    queue_length = __MODULE__.length(queue)

    if queue_length >= n do
      :queue.split(n, queue)
    else
      :queue.split(queue_length, queue)
    end
  end

  defdelegate length(queue), to: :queue, as: :len
  defdelegate to_list(queue), to: :queue
  defdelegate is_empty?(queue), to: :queue, as: :is_empty
  defdelegate is_queue?(queue), to: :queue, as: :is_queue
  defdelegate new(), to: :queue
end
