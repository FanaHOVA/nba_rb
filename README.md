# nba_rb

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
