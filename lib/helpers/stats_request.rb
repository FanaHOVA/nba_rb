module StatsRequest
  def stats_request(endpoint, params)
    res = HTTParty.get(NbaRb::BASE_URL + endpoint,
                       query: params,
                       headers: { 'Content-Type' => 'application/json',
                                  'Accept' => 'application/json'
                                }
                      )

    res.parsed_response
  end
end
