defmodule BigBadBot.Messages.MessageEdit do
  use Ecto.Schema

  import Ecto.Changeset

  schema "message_edits" do
    field(:content, :string)
    field(:discord_timestamp, :utc_datetime_usec)

    timestamps()
    belongs_to(:message, BigBadBot.Messages.Message)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:content, :discord_timestamp])
    |> cast_assoc(:message)
    |> validate_required([:message, :discord_timestamp])
  end
end
