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
        Api.create_message(msg.channel_id, "pong!")

      "!raise" ->
        raise "No problems here"

      _ ->
        :ignore
    end
  end

  def handle_event({:READY, data = %Nostrum.Struct.Event.Ready{}, _ws_state}) do
    IO.puts("Ready Event")

    IO.inspect(data)

    command = %{
      name: "hellahomosexual",
      description: "Just Touch me"
    }

    register_commands(command)
  end

  def handle_event(
        {:INTERACTION_CREATE, %{data: %{name: "hellahomosexual"}} = interaction, _state}
      ) do
    Api.create_interaction_response(interaction, %{
      type: 4,
      data: %{
        content:
          "Damn these niggas gay <@199586460293267456><@262633651110543371><@249970891008507905>",
        allowed_mentions: %{
          parse: ["users"]
        }
      }
    })
  end

  def handle_event(event) do
    IO.inspect(event)

    :noop
  end

  defp register_commands(command) do
    IO.inspect(Nostrum.Api.create_global_application_command(command))
  end
end
