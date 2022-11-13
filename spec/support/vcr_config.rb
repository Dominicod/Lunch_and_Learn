# frozen_string_literal: true

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data('ED_APP_ID') { ENV['ED_APP_ID'] }
  config.filter_sensitive_data('ED_APP_KEY') { ENV['ED_APP_KEY'] }
  config.filter_sensitive_data('GOOGLE_API_KEY') { ENV['GOOGLE_API_KEY'] }
  config.filter_sensitive_data('UNSPLASH_CLIENT') { ENV['UNSPLASH_CLIENT'] }
end
