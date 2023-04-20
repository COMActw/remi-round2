# frozen_string_literal: true

require 'uri'
class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def create
    return redirect_to new_video_path, flash: { danger: 'Invalid URL' } if video_create_params.nil?

    @video = Video.new(video_create_params)
    @video.save
    respond_to do |format|
      format.html { redirect_to root_path, flash: { success: 'Video was successfully created' } }
    end
  end

  def video_info
    return nil unless valid_url?(video_params[:url])

    @video_info = VideoInfo.new(video_params[:url]) unless video_params[:url].blank?
  end

  private

  def valid_url?(url)
    yts_regexp = %r{^https://(?:www\.)?youtube.com/watch\?(?=[^?]*v=\w+)(?:[^\s?]+)?$}
    yt_regexp = %r{^http://(?:www\.)?youtube.com/watch\?(?=[^?]*v=\w+)(?:[^\s?]+)?$}

    if yts_regexp.match(url) || yt_regexp.match(url)
      true
    else
      false
    end
  end

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

  def video_params
    params.require(:video).permit(:url)
  end
end
