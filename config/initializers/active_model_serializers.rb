# frozen_string_literal: true

ActiveModelSerializers.config.adapter = :json_api
ActiveModelSerializers.config.key_transform = :camel_lower

api_mime_types = %w[
  application/vnd.api+json
  text/x-json
  application/json
]
Mime::Type.register "application/vnd.api+json", :json, api_mime_types
