# frozen_string_literal: true

require 'tty-prompt'
require 'time'
require 'yaml'

# Saving for hangman game
module Saving
  private

  attr_accessor :prompt

  def wanna_save?
    self.prompt = TTY::Prompt.new

    puts
    prompt.select('What will you do?') do |menu|
      menu.choice 'Guess', false
      menu.choice 'Save', true
    end
  end

  def save_game
    dump = YAML.dump({ word: word, letters: letters, guesses_left: guesses_left })
    File.write("#{ROOT}/saves/#{generate_save_name}.yaml", dump)

    puts
    puts 'Your game saved!'
  end

  def generate_save_name = "#{letters} | Guesses left: #{guesses_left} | #{Time.now.strftime('%d.%m.%Y %H:%M:%S')}"
end
