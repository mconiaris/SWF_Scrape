# SWF_Scrape

## Description
This program scrapes PDF cards from the Pro Wrestling Superstar game (an online simulation of a mid-1980s board game, which may be purchased here: https://prowrestlingsuperstar.com), converts them to Ruby objects and then analyzes the relative strength of them based on points per round, as well as pin, sub, DQ percentage possibilities and priority rankings. The program retuns a CSV file with the values of the cards analyzed by the program.

It is very much in Beta right now.

There is an active group online (https://groups.io/g/SuperstarProWrestlingAlliance) that enjoys the game and shares their results with each other.

## Directions for Use
### Terminal
1. Install Github and create an account: https://lifehacker.com/5983680/how-the-heck-do-i-use-github
2. Clone my repository: https://help.github.com/articles/cloning-a-repository/
3. Ensure that you have at least ruby 2.4.3 by typing `ruby -v`
4. `cd` into the program's folder.
5. Type `touch files/input.txt` and press enter.
6. Copy and paste links to the specific PDFs that you want analyzed into your input file.
7. Type `ruby main.rb` and press enter.
8. Open up the results.csv file using Excel or any other spreadsheet file and format any numbers that may have been outputted as text.
### On the Web
Coming soon.

## Dependencies
- PDF Reader: https://github.com/yob/pdf-reader

## Documentation
- Pro Wrestling Superstar Game: https://prowrestlingsuperstar.com
- Notes on the original Superstar Pro Wrestling Game (1984) board game: https://boardgamegeek.com/boardgame/11188/superstar-pro-wrestling-game
- RSpec: https://relishapp.com/rspec/rspec-core/v/3-8/docs
- Rspec (Conventions): http://www.betterspecs.org/

## Tutorials
- How to scrape a document: https://medium.com/@luke_duncan/how-to-scrape-a-pdf-for-keywords-using-ruby-a8ffa47c186e
- rspec: https://semaphoreci.com/community/tutorials/getting-started-with-rspec

## REGEX
- REGEX helper: http://rubular.com/
