require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<MORPH_API_KEY>') { ENV['MORPH_SECRET_KEY'] }
  c.default_cassette_options = { record: :new_episodes }
end
