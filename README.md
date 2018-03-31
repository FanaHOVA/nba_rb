# nba_rb

[![CircleCI](https://circleci.com/gh/FanaHOVA/nba_rb/tree/master.svg?style=svg)](https://circleci.com/gh/FanaHOVA/nba_rb/tree/master)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/6cd1ce1f16d44e279a5856d8294f1b1b)](https://www.codacy.com/app/FanaHOVA/nba_rb?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=FanaHOVA/nba_rb&amp;utm_campaign=Badge_Grade)
[![Gem](https://img.shields.io/gem/v/nba_rb.svg?style=flat)](http://rubygems.org/gems/nba_rb "View this project in Rubygems")
[![MIT license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)


nba_rb is a Ruby wrapper for the `stats.nba.com` API. It supports most endpoints (feel free to open an issue if something is missing!) and provides helper methods to extract certain information from the responses. 

There's three main modules: `NbaRb::Game`, `NbaRb::Team`, `NbaRb::Player`. Each of them contains classes related to endpoints for that scope. You can find some examples in the `spec` folder, I plan to write some more docs in the future (Happy to see PRs for this!). 

Here's a couple more examples:

```
# Getting the Boxscore for one of today's games
todays_schedule = NbaRb::Game::TodaySchedule.new
todays_first_game_id = todays_schedule.matchup_teams_info[0]['GAME_ID'] # Get the Game ID of the first game
game_boxscore = NbaRb::Game::Boxscore.new(game_id: todays_first_game_id)
```

```
# Find Suns stats from a game they played 5 days ago
5_days_ago_schedule = NbaRb::Game::TodaySchedule.new(game_date: Date.today - 5)
game =  todays_schedule.matchup_teams_info.select { |data| data['TEAM_ABBREVIATION'] == 'PHX' }.first
game_boxscore = NbaRb::Game::Boxscore.new(game_id: game['GAME_ID'])
game_stats = game_boxscore.line_score.select { |data| data['TEAM_ABBREVIATION'] == 'PHX' }.first
puts "The #{game_stats['TEAM_CITY']} #{game_stats['TEAM_NAME']} scored #{game_stats['PTS']} points on #{game_stats['FGM']}/#{game_stats['FGA']} shooting"
```
