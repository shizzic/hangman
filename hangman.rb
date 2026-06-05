# frozen_string_literal: true

# Hangman cmd game
class Hangman
  def initialize
    words = File.readlines './google-10000-english-no-swears.txt'
    self.word = words[rand(0..9999)].chomp.strip

    self.letters = Array.new(word.size, '_')
    self.guesses_left = (word.size * 1.5).ceil
  end

  def start
    greet_and_explain
    to_s
  end

  private

  attr_accessor :word, :letters, :guesses_left

  def choose_random_word
    words = File.readlines './google-10000-english-no-swears.txt'

    loop do
      word = words[rand(0..9999)].chomp.strip
      return word if (5..12).cover?(word.size)
    end
  end

  def to_s
    puts <<~TEXT

      #{letters.join ' '}
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
end

Hangman.new.start
