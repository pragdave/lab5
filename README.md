We're going to turn the Hangman game into a GenServer.

This shouldn't involve any changes to lib/hangman/game.ex

However, we will have to change lib/hangman.ex. It will have exactly
the same API as before, but it will pass messages to a GenServer
instead of delegating directly to Hangman.Game.

The server will be in a new file: lib/hangman/server.ex. It will
implement init/1 and the handle_call functions.

There's a subtlety here.

In the old API, Hangman.make_move returned {game, tally}.

In this new implementation, the representation of the game is just the pid of the GenServer, and the call to HangMan.make_move will have to add that pid back in to the return value in order to maintain the API. Thus, the lib/dictionary.ex module will containing

``` elixir
defmodule Hangman do

  def new_game() do
    Dictionary.start_link
    new_game(Dictionary.random_word)
  end

  def new_game(word) do
    { :ok, pid } = GenServer.start_link(Hangman.Server, [word])
    pid
  end

  def make_move(pid, guess) do
    result = GenServer.call(pid, {:make_move, guess})
    { pid, result }
  end
  
  def tally(pid) do
    GenServer.call(pid, {:tally})
  end

end

```
