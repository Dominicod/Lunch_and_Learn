# frozen_string_literal: true

module ServiceHelperModule # rubocop:todo Style/Documentation
  def self.encode_uri(uri)
    CGI.escape(uri)
  end
end
