# frozen_string_literal: true

require_relative 'lib/player'
require_relative 'lib/saving'

ROOT = __dir__

# Hangman cmd game
class Hangman
  include Player
  include Saving

  UNGUESSED_CHAR = '_'
  MAX_TRIES = 6

  def initialize
    choose_random_word # word

    self.letters = UNGUESSED_CHAR * word.size # correctly guessed letters
    self.guesses_left = MAX_TRIES
  end

  def start
    saves? && wanna_load_save? ? load_save : greet_and_explain
    to_s

    until guesses_left.zero? || word == letters
      save_game if wanna_save? # ask player if he wants to save

      letter = guess
      open_letter(letter)

      to_s
    end

    declare
  end

  private

  attr_accessor :word, :letters, :guesses_left

  def open_letter(target_letter)
    puts

    word.chars.each_with_index do |letter, index|
      next unless letter == target_letter && letters[index] == UNGUESSED_CHAR

      puts 'Success'
      return letters[index] = letter
    end

    puts 'Wrong.'
    puts "The target word doesn't have #{target_letter} in itself in current state."
    self.guesses_left -= 1
  end

  def choose_random_word
    words = File.readlines './google-10000-english-no-swears.txt'

    loop do
      word = words[rand(0..9999)].chomp.strip.downcase
      break self.word = word if (5..12).cover?(word.size)
    end
  end

  def to_s
    puts <<~TEXT

      #{letters.chars.join ' '}
      Guesses left: #{guesses_left}
    TEXT
  end

  def greet_and_explain
    puts <<~TEXT

      Welcome to Hangman game.
      You need to guess the whole word letter by letter. Possible length between 5 and 12 (included).

      1. Each turn you need to type an alphabetic english letter (a-z). Case insensitive.
      2. You will see how many guesses left after each turn.
      3. You will see all correctly guessed letters after each turn.
    TEXT
  end

  def declare
    puts
    puts word == letters ? 'You won!' : 'You lost.'
  end
end

Hangman.new.start
