class Api::V1::BackgroundsController < ApplicationController
  def show
    render json: background_image
  end

  private

  def background_image
    background_retriever.find_or_fetch(keywords: params[:location])
  end

  def background_retriever
    BackgroundRetriever.new
  end
end
