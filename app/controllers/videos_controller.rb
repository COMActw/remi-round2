# frozen_string_literal: true

class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_create_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to root_path }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def video_create_params
    return if video_info.nil?

    @video_create_params = {
      title: video_info.title,
      shared_by: current_user.email,
      description: video_info.description,
      url: video_params[:url],
      embed_code: video_info.embed_code
    }
  end

  def video_info
    @video_info = VideoInfo.new(video_params[:url]) unless video_params[:url].blank?
  end

  def video_params
    params.require(:video).permit(:url)
  end
end
