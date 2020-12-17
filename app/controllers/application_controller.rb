class ApplicationController < ActionController::API
  include ActionController::Serialization

  include BaseApi

  serialization_scope nil

  def authenticate_account!
    handle_error :account_unauthenticated unless current_account
  end

  private
  def token_access_header
    auth_header = request.headers[Settings.token_access_header]
    return nil unless auth_header

    auth_header.scan(/^#{Settings.token_access_prefix} (.+)$/i).dig 0, 0
  end

  def current_account
    @current_account ||= Account.find payload[0]["account_id"] if payload.present?
  end

  def payload
    @payload ||= JsonWebToken.decode token_access_header if token_access_header
  end

  def collection_serializer data, model, scope = {}
    ActiveModelSerializers::SerializableResource.new data, adapter: :attributes, scope: scope, each_serializer: model
  end
end
