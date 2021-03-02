class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @videos = FetchYoutubeVideos.call(YoutubeSession.last)
  end

  def about
  end
end
