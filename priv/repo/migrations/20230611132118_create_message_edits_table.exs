defmodule BigBadBot.Repo.Migrations.CreateMessageEditsTable do
  use Ecto.Migration

  def change do
    create table(:message_edits) do
      add :message_id, references(:messages)
      add :content, :text

      timestamps()
    end

  end
end
