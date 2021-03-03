class PublishingsController < ApplicationController
  before_action :set_publishing, only: [:show, :edit, :update, :destroy]

  def index
    @publishings = Publishing.all
  end

  def show
    @Publishing = Publishing.new
  end

  def new
    @publishing = Publishing.new
  end

  def edit
  end

  def create
    @publishing = Publishing.new(publishing_params)
    @publishing.user = current_user
    if @publishing.save
      redirect_to publishings_path(@publishing)
    else
      render :new
    end
  end

  def update
    if @publishing.update(publishing_params)
      redirect_to publishing_path(@publishing)
    else
      render :edit
    end
  end

  # def destroy
  #   if @publishing.destroy
  #     redirect_to publishings_path(@publishing)
  #   else
  #     render :index
  #   end
  # end

  def overview
    # @videos = FetchYoutubeVideos.call(YoutubeSession.last)
    # if YoutubeSession.last[:client_secret] != nil
    if YoutubeSession.last.nil?
      redirect_to youtube_sessions_path
    else
      @videos = FetchYoutubeVideos.call(YoutubeSession.last)
    end
  end

  private

  def set_publishing
    @publishing = Publishing.find(params[:id])
  end

  def publishing_params
    params.require(:publishing).permit(:video, :title, :description, :status, :uid )
  end
end
