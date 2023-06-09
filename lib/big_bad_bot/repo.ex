defmodule BigBadBot.Repo do
  use Ecto.Repo,
    otp_app: :big_bad_bot,
    adapter: Ecto.Adapters.Postgres
end
