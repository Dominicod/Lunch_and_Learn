# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  private

  def render_unprocessable_entity(exception)
    render json: unprocessable_entity(exception), status: :unprocessable_entity
  end

  def unprocessable_entity(exception)
    errors = exception.message.split(':')[1].split(',').map(&:strip)
    ErrorSerializer.new(
      Error.new({ code: '422', status: Rack::Utils::HTTP_STATUS_CODES[422], message: errors })
    ).serializable_json
  end
end
