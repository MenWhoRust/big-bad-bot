defmodule BigBadBotConsumer do
  use Nostrum.Consumer

  require Logger

  alias Nostrum.Api
  alias BigBadBot.Repo
  alias Message

  def start_link() do
    Consumer.start_link(__MODULE__)
  end

  # def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
  #   IO.inspect(msg)

  #   case msg.content do
  #     "!sleep" ->
  #       Api.create_message(msg.channel_id, "Going to sleep...")
  #       Process.sleep(3000)

  #     "!ping" ->
  #       Api.create_message(msg.channel_id, "pong!")

  #     "!raise" ->
  #       raise "No problems here"

  #     _ ->
  #       :ignore
  #   end
  # end

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

  def handle_event({:MESSAGE_UPDATE, msg = %Nostrum.Struct.Message{}, _state} = event) do
    IO.inspect(event, label: "Message edit Inserter")

    found_message = BigBadBot.Messages.get_message_by_message_id(msg.id)

    process_message(msg, found_message)
  end

  def handle_event({:MESSAGE_CREATE, msg = %Nostrum.Struct.Message{}, _state} = event) do
    IO.inspect(event, label: "Message Inserter")

    %BigBadBot.Messages.Message{
      user_id: msg.author.id,
      username: msg.author.username,
      channel_id: msg.channel_id,
      guild_id: msg.guild_id,
      content: msg.content,
      message_id: msg.id,
      discord_timestamp: msg.timestamp
    }
    |> BigBadBot.Messages.Message.changeset(%{})
    |> Repo.insert()
  end

  def handle_event(event) do
    IO.inspect(event, label: "Default Event Handler")
    :noop
  end

  defp register_commands(command) do
    IO.inspect(Nostrum.Api.create_global_application_command(command))
  end

  def process_message(_, nil), do: nil

  def process_message(discord_message, db_message) do
    %BigBadBot.Messages.MessageEdit{
      message: db_message,
      content: discord_message.content,
      discord_timestamp: discord_message.edited_timestamp
    }
    |> BigBadBot.Messages.MessageEdit.changeset(%{})
    |> Repo.insert()
  end
end
