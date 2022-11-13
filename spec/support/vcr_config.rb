# frozen_string_literal: true

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.default_cassette_options = { re_record_interval: 7.days }
  config.filter_sensitive_data('DONT SHOW MY API KEY') { ENV['ED_APP_ID'] }
  config.filter_sensitive_data('DONT SHOW MY API KEY') { ENV['ED_APP_KEY'] }
  config.filter_sensitive_data('DONT SHOW MY API KEY') { ENV['GOOGLE_API_KEY'] }
  config.filter_sensitive_data('DONT SHOW MY API KEY') { ENV['UNSPLASH_CLIENT'] }
end
