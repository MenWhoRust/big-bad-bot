defmodule BigBadBot.Repo.Migrations.AddMicrosecondsToDiscordTimestamp do
  use Ecto.Migration

  def change do
    alter table :messages do
      modify :discord_timestamp, :utc_datetime_usec
    end
    alter table :message_edits do
      modify :discord_timestamp, :utc_datetime_usec
    end

  end
end
