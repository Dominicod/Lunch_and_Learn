# frozen_string_literal: true

module ServiceHelperModule
  def self.encode_uri(uri)
    CGI.escape(uri)
  end
end
