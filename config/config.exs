import Config

config :nostrum,
  token: System.get_env("DISCORD_API_KEY"),
  gateway_intents: [:message_content, :guild_messages]

config :big_bad_bot, ecto_repos: [BigBadBot.Repo]

config :big_bad_bot, BigBadBot.Repo,
  database: System.get_env("BOT_DATABASE_NAME"),
  username: System.get_env("BOT_DATABASE_USERNAME"),
  password: System.get_env("BOT_DATABASE_PASSWORD"),
  hostname: System.get_env("BOT_DATABASE_HOSTNAME")
