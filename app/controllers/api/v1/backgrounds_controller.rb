class Api::V1::BackgroundsController < ApplicationController
  def show
    render json: background_image
  end

  private

  def background_image
    background_writer.find_or_fetch(keywords: params[:location])
  end

  def background_writer
    BackgroundWriter.new
  end
end
