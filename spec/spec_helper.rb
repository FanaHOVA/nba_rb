$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'nba_rb'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.around(:each) do |example|
    VCR.use_cassette(example.metadata[:description], {}, &example)
  end
end
