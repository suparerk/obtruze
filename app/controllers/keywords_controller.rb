class KeywordsController < ApplicationController
  before_action :set_keyword, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_token

  # GET /keywords
  def index
    @keywords = Keyword.all
  end

  # GET /keywords/1
  def show

  end

  # GET /keywords/new
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

    if keyword_array
    redirect_to keywords_path, notice: 'Keyword was successfully created.'
    else
    redirect_to new_keyword_path, notice: 'No new keyword found.'
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
