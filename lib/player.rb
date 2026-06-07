# frozen_string_literal: true

# Player of hangman game
module Player
  def guess
    tried = false

    loop do
      puts
      puts 'Input must be a letter: a-z (case insensetive).' if tried == true
      print 'Your guess: '

      input = gets.chomp.strip.downcase
      return input if ('a'..'z').cover?(input)

      tried = true
    end
  end
end
