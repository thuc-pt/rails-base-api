module Api::V1
  class ApiDocsController < ApplicationController
    include Swagger::Blocks

    swagger_root do
      key :swagger, "2.0"
      info do
        key :version, "1.0"
        key :title, I18n.t("api_docs.title")
        key :description, I18n.t("api_docs.description")
      end
    end

    SWAGGERED_CLASSES = [
      self
    ].freeze

    def index
      render json: Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
    end

    private
    def process_account_token_and_response account
      authen_token = JsonWebToken.encode generate_attr(account)

      json_response(:created, token: authen_token, exp: Time.zone.at(JsonWebToken.meta[:exp]),
                    account: AccountSerializer.new(account))
    end

    def generate_attr account
      {account_id: account.id, email: account.email}
    end
  end
end
