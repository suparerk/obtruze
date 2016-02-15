module Api
  module V1
    class KeywordsController < Api::V1::ApiController

      skip_before_action :authenticate_token
      before_action :set_keyword, only: [:show, :edit, :update, :destroy]
      respond_to :json

      def index
        @keywords = Keyword.all
        respond_with @keywords
      end

      def show
        respond_with @keyword
      end

      def new
        @keyword = Keyword.new
        @result = @keyword.build_result
      end

      # GET /keywords/1/edit
      def edit
      end

      # POST /keywords
      def create
        keyword_array = Keyword.import(params[:file])

        # if keyword_array
        # redirect_to keywords_path, notice: 'Keyword was successfully created.'
        # else
        # redirect_to new_keyword_path, notice: 'No new keyword found.'
        # end
        if keyword_array
          redirect_to api_v1_keywords_path
        else
          render json: {message: "Unable to create"}, status: :unprocessable_entity
        end

      end

      # PATCH/PUT /keywords/1
      def update

      end

      # DELETE /keywords/1
      def destroy
        @keyword.destroy
        redirect_to keywords_url, notice: 'Keyword was successfully destroyed.'
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_keyword
          @keyword = Keyword.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def keyword_params
          # params.fetch(:keyword, {})
          params.require(:keyword)
        end
    end
  end
end
