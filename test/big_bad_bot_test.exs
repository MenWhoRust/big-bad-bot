defmodule BigBadBotTest do
  use ExUnit.Case
  doctest BigBadBot

  test "greets the world" do
    assert BigBadBot.hello() == :world
  end
end
