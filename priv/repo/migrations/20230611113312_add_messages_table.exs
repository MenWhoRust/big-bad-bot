defmodule BigBadBot.Repo.Migrations.AddMessagesTable do
  use Ecto.Migration

  def change do

    create table("messages") do
      add :message_id, :bigint
      add :username, :string
      add :user_id, :bigint
      add :guild_id, :bigint
      add :channel_id, :bigint
      add :content, :string

      timestamps()


    end

    create unique_index :messages, :message_id
  end
end
