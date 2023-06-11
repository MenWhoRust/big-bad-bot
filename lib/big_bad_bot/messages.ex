defmodule BigBadBot.Messages do
  import Ecto.Query

  alias BigBadBot.Repo

  def get_message_by_message_id(message_id) do
    Repo.one(from(m in BigBadBot.Messages.Message, where: m.message_id == ^message_id))
  end
end
