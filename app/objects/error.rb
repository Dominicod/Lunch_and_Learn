# frozen_string_literal: true

class Error
  attr_reader :code,
              :status,
              :message

  def initialize(response)
    @code = response[:code]
    @status = response[:status]
    @message = response[:message]
  end
end
