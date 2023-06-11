defmodule BigBadBot.Messages.Message do
  use Ecto.Schema

  import Ecto.Changeset

  schema "messages" do
    field(:message_id, :integer)
    field(:username, :string)
    field(:user_id, :integer)
    field(:guild_id, :integer)
    field(:channel_id, :integer)
    field(:content, :string)
    field(:discord_timestamp, :utc_datetime_usec)

    timestamps()

    has_many(:message_edits, BigBadBot.Messages.MessageEdit)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :message_id,
      :username,
      :user_id,
      :guild_id,
      :channel_id,
      :content,
      :discord_timestamp
    ])
    |> validate_required([
      :message_id,
      :username,
      :user_id,
      :guild_id,
      :channel_id,
      :content,
      :discord_timestamp
    ])
    |> unique_constraint(:message_id)
  end
end
