# frozen_string_literal: true

require 'tty-prompt'
require 'time'
require 'yaml'

# Saving for hangman game
module Saving
  private

  attr_accessor :prompt

  def wanna_load_save?
    self.prompt = TTY::Prompt.new

    puts
    prompt.select('Wanna load a save?') do |menu|
      menu.choice 'No', false
      menu.choice 'Yes', true
    end
  end

  def load_save
    puts
    path_to_save = prompt.select('Which save to load?') do |menu|
      Dir.glob("#{ROOT}/saves/*.yaml").reverse_each { |path| menu.choice File.basename(path, '.yaml'), path }
    end

    data = YAML.load_file(path_to_save)

    self.guesses_left = data[:guesses_left]
    self.letters = data[:letters]
    self.word = data[:word]
  end

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

  def saves? = Dir.glob("#{ROOT}/saves/*.yaml").any?
end
