defmodule Extra.PublishingManager.ConsumerTest do
  use ExUnit.Case
  alias Extra.PublishingManager.Consumer
  alias Extra.PublishingManager.Collector

  test "child_spec" do
    assert Consumer.child_spec([:testing]) == %{
      id: Extra.PublishingManager.Consumer,
      restart: :permanent,
      start: {Extra.PublishingManager.Consumer, :start_link, [[:testing]]},
      type: :supervisor
    }
  end

  test "processes do stuff" do
    {:ok, collector} = Collector.start_link()
    {:ok, consumer} = Consumer.start_link()
    # monitor = Process.monitor(consumer)

    Collector.add("a timeslot")

    GenStage.stop(consumer)
    GenStage.stop(collector)
  end
end
