defmodule BigBadBotConsumer do
  use Nostrum.Consumer

  require Logger

  alias Nostrum.Api

  def start_link() do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    IO.inspect(msg)

    case msg.content do
      "!sleep" ->
        Api.create_message(msg.channel_id, "Going to sleep...")
        Process.sleep(3000)

      "!ping" ->
        Api.create_message(msg.channel_id, "pyongyang!")

      "!raise" ->
        raise "No problems here"

      _ ->
        :ignore
    end
  end

  def handle_event(_event) do
    :noop
  end
end
