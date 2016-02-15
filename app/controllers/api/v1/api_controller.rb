module Api
  module V1
    class ApiController < ActionController::Base

      # before_action :authenticate_token
      skip_before_action :verify_authenticity_token

      # rescue_from TokenAuthentication::InvalidRequest, with: :invalid_request

      def invalid_request
        render json: { error: {success: false, message: 'invalid request'}}, status: 400
      end

    end
  end
end
