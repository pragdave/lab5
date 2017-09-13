defmodule HangmanTest do
  use ExUnit.Case

  test "first occurrence of letter is not already used" do
    game = Hangman.new_game("wibble")
    { _game, tally } = Hangman.make_move(game, "x")
    assert tally.game_state != :already_used
  end

  test "second occurrence of letter is already used" do
    game = Hangman.new_game("wibble")
    { _, tally } = Hangman.make_move(game, "x")
    assert tally.game_state != :already_used
    { _, tally } = Hangman.make_move(game, "x")
    assert tally.game_state == :already_used
  end
  
  test "a good guess is recognized" do
    game = Hangman.new_game("wibble")
    { _, tally } = Hangman.make_move(game, "w")
    assert tally.game_state == :good_guess
    assert tally.turns_left == 7
  end
  
  test "a guessed word is a won game" do
    game = Hangman.new_game("wibble")
    { _, tally } = Hangman.make_move(game, "w")
    assert tally.game_state == :good_guess
    assert tally.turns_left == 7
    { _, tally } = Hangman.make_move(game, "i")
    assert tally.game_state == :good_guess
    assert tally.turns_left == 7
    { _, tally } = Hangman.make_move(game, "b")
    assert tally.game_state == :good_guess
    assert tally.turns_left == 7
    { _, tally } = Hangman.make_move(game, "l")
    assert tally.game_state == :good_guess
    assert tally.turns_left == 7
    { _, tally } = Hangman.make_move(game, "e")
    assert tally.game_state == :won
    assert tally.turns_left == 7
  end
  
  test "bad guess is recognized" do
    game = Hangman.new_game("wibble")
    { _, tally } = Hangman.make_move(game, "x")
    assert tally.game_state == :bad_guess
    assert tally.turns_left == 6
  end
  
  test "lost game is recognized" do
    game = Hangman.new_game("w")
    { _, tally } = Hangman.make_move(game, "a")
    assert tally.game_state == :bad_guess
    assert tally.turns_left == 6
    { _, tally } = Hangman.make_move(game, "b")
    assert tally.game_state == :bad_guess
    assert tally.turns_left == 5
    { _, tally } = Hangman.make_move(game, "c")
    assert tally.game_state == :bad_guess
    assert tally.turns_left == 4
    { _, tally } = Hangman.make_move(game, "d")
    assert tally.game_state == :bad_guess
    assert tally.turns_left == 3
    { _, tally } = Hangman.make_move(game, "e")
    assert tally.game_state == :bad_guess
    assert tally.turns_left == 2
    { _, tally } = Hangman.make_move(game, "f")
    assert tally.game_state == :bad_guess
    assert tally.turns_left == 1
    { _, tally } = Hangman.make_move(game, "g")
    assert tally.game_state == :lost
  end
  
end 
