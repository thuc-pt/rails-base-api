module Response
  extend ActiveSupport::Concern

  included do
    def exception_format exception, code
      {
        error_code: code,
        error_message: exception.message.to_s.split("::").last
      }
    end

    def json_response status, object = {}
      render json: {
        success: object.try(:[], :error_code).blank?,
        data: object
      }.to_json, status: status
    end
  end
end
