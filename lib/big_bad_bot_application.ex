defmodule BigBadBotApplication do
  use Application

  @impl true
  def start(_type, _args) do
    children = [BigBadBot, BigBadBot.Repo]

    options = [strategy: :rest_for_one, name: BigBadBotSupervisor]
    Supervisor.start_link(children, options)
  end
end
