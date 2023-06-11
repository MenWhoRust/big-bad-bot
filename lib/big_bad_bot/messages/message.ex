defmodule Message do
  use Ecto.Schema

  import Ecto.Changeset

  schema "messages" do
    field(:message_id, :integer)
    field(:username, :string)
    field(:user_id, :integer)
    field(:guild_id, :integer)
    field(:channel_id, :integer)
    field(:content, :string)

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:message_id, :username, :user_id, :guild_id, :channel_id, :content])
    |> validate_required([:message_id, :username, :user_id, :guild_id, :channel_id, :content])
    |> unique_constraint(:message_id)
  end
end
