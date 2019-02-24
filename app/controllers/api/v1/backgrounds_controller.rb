class Api::V1::BackgroundsController < ApplicationController
  def show
    render json: background, each_serializer: BackgroundSerializer
  end

  private

  def background
    background_writer.find_or_fetch(keywords: params[:location])
  end

  def background_writer
    BackgroundWriter.new
  end
end
