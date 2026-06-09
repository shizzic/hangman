# Hangman

Command-line Hangman game written in Ruby.

## Features

- Random word selected from a 10,000-word dictionary (5–12 characters)
- 6 attempts per game
- Save and load game state at any turn
- Save files named by current progress and timestamp

## Requirements

- Ruby 4.0.4
- Bundler

## Installation

```
bundle install
```

## Usage

```
ruby hangman.rb
```

Each turn you can choose to save the game or make a guess. Saves are stored in the `saves/` directory and can be loaded on the next run.

## Project Structure

```
hangman/
├── hangman.rb                          # entry point
├── lib/
│   ├── player.rb                       # input handling
│   └── saving.rb                       # save/load logic
├── saves/                              # save files
└── google-10000-english-no-swears.txt  # word list
```
