class ErrorSerializer
  include JSONAPI::Serializer
  attributes :code, :status, :message
end
