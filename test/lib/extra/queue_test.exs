defmodule Extra.QueueTest do
  use ExUnit.Case, async: true

  alias Extra.Queue

  setup do
    queue = Queue.new
    {:ok, queue: queue}
  end

  test "enqueue/2", %{queue: queue} do
    queue = Queue.enqueue(queue, "1")
    assert queue == {["1"], []}
    queue = Queue.enqueue(queue, "2")
    assert queue == {["2"], ["1"]}
  end

  test "pop/2", %{queue: queue} do
    queue =
      queue
      |> Queue.enqueue(1)
      |> Queue.enqueue(2)

    assert {1, queue} = Queue.pop(queue)
    assert {2, queue} = Queue.pop(queue)
    assert {nil, {[], []}} = Queue.pop(queue)
  end

  test "split/2", %{queue: queue} do
    queue = Enum.reduce(1..10, queue, &Queue.enqueue(&2, &1))
    assert {{[3, 2], [1]}, {[10], [4, 5, 6, 7, 8, 9]}} == Queue.split(queue, 3)
  end

  test "take/2", %{queue: queue} do
    queue = Enum.reduce(1..10, queue, &Queue.enqueue(&2, &1))
    assert queue == {[10, 9, 8, 7, 6, 5, 4, 3, 2], [1]}

    assert {results, queue} = Queue.take(queue, 3)

    assert results == [1, 2, 3]
    assert queue == {[10], [4, 5, 6, 7, 8, 9]}
  end

  test "is_empty?/1", %{queue: queue} do
    assert true == Queue.is_empty?(queue)
    queue = Queue.enqueue(queue, "hi")
    assert false == Queue.is_empty?(queue)
  end

  test "length/1", %{queue: queue} do
    assert 0 == Queue.length(queue)
    queue = Queue.enqueue(queue, "hi")
    assert 1 == Queue.length(queue)
  end

  test "is_queue?/1", %{queue: queue} do
    assert true == Queue.is_queue?(queue)
    assert false == Queue.is_queue?("not a queue")
  end
end
