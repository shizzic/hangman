# frozen_string_literal: true

# Player of hangman game
class Player
  def guess
    try = 0

    loop do
      puts
      puts 'Input must be a letter: a-z (case insensetive).' unless try.zero?
      print 'Your guess: '

      input = gets.chomp.strip.downcase
      return input if ('a'..'z').cover?(input)

      try += 1
    end
  end
end
