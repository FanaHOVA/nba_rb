module StatsRequest
  def stats_request(endpoint, params)
    res = HTTParty.get(NbaRb::BASE_URL + endpoint,
                       query: params,
                       headers: {
                        'user-agent': ('Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36'),  # noqa: E501
                        'Dnt': ('1'),
                        'Accept-Encoding': ('gzip, deflate, sdch'),
                        'Accept-Language': ('en'),
                        'origin': ('http://stats.nba.com')
                      }
    )

    res.parsed_response
  end
end
