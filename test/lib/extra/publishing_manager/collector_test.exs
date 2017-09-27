defmodule Extra.PublishingManager.CollectorTest do
  use ExUnit.Case

  alias Extra.PublishingManager.Collector

  test "Stores stuff ane sends it onwards." do
    {:ok, collector} = Collector.start_link()
    for n <- 1..100 do
      Collector.add(n)
    end

    stream = GenStage.stream([{Collector, max_demand: 1, cancel: :transient}])
    response = Enum.take(stream, 5)
    assert response  == [1, 2, 3, 4, 5]

    response = Enum.take(stream, 5)
    assert response  == [6, 7, 8, 9, 10]

    GenStage.stop(collector)
  end
end
