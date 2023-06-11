defmodule BigBadBot.Repo.Migrations.AddDiscordTimestampsToMessagesAndEdits do
  use Ecto.Migration

  def change do
    alter table(:messages) do
      add :discord_timestamp, :utc_datetime
    end

    alter table(:message_edits) do
      add :discord_timestamp, :utc_datetime
    end

    execute("update messages set discord_timestamp = CURRENT_TIMESTAMP")
    execute("update message_edits set discord_timestamp = CURRENT_TIMESTAMP")


    alter table(:messages) do
      modify :discord_timestamp, :utc_datetime, null: false
    end

    alter table(:message_edits) do
      modify :discord_timestamp, :utc_datetime, null: false
    end

  end
end
