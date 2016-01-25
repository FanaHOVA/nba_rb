module StatsHash
  def create_stats_hash(data)
    stats = []
    data['rowSet'].each do |row|
      row_hash = {}
      data['headers'].each_with_index do |header, index|
        row_hash[header] = row[index]
      end
      stats << row_hash
    end
    stats
  end
end
