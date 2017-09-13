defmodule Hangman.Game do

  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters:    [],
    used:       MapSet.new(),
    last_guess: "",
  )

  def new_game(word) do
    %Hangman.Game{
      letters: word |> String.codepoints
    }
  end
  
  def new_game() do
    new_game(Dictionary.random_word)
  end

  def make_move(game = %{ game_state: state }, _guess)
  when state in [:won, :lost] do
    game
    |> return_with_tally()
  end

  def make_move(game, guess) do
    game
    |> Map.put(:last_guess, guess)
    |> accept_move(MapSet.member?(game.used, guess))
    |> return_with_tally()
  end

  def tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      letters:    game.letters |> reveal_guessed(game.used),
      used:       game.used    |> MapSet.to_list |> Enum.sort(),
      last_guess: game.last_guess,
    }
  end


  ############################################################
  ## your code goes here...
  
  defp accept_move(game, already_guessed) do
     # ...
  end

  # other functions you write


  # and some helpers I wrote...

  
  defp reveal_guessed(letters, used) do
    letters
    |> Enum.map(fn letter -> reveal_letter(letter, MapSet.member?(used, letter)) end)
  end

  defp reveal_letter(letter, _in_word = true),  do: letter
  defp reveal_letter(_letter, _not_in_word),    do: "_"

  
  defp return_with_tally(game), do: { game, tally(game) }
  
end
