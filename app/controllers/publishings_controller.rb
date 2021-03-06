class PublishingsController < ApplicationController
  before_action :set_publishing, only: [:show, :edit, :update, :destroy, :myvideo]

  def index
    @publishings = Publishing.all
  end

  def show
    # Aca seria solo set_publishing
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

  def mypublishings
    @publishings = Publishing.where(user: current_user)
  end

  def insight

  end

  # def destroy
  #   if @publishing.destroy
  #     redirect_to publishings_path(@publishing)
  #   else
  #     render :index
  #   end
  # end
  def update_publishings # Boton
    @data = FetchYoutubeAnalytics.call(current_user.youtube_sessions.last) # video_id: view , likes
    @videos = FetchYoutubeVideos.call(current_user.youtube_sessions.last) # Published videos in YT
      @videos.each do |video_hash|
        publishing = Publishing.find_or_initialize_by(uid: video_hash[:id])
        if publishing.id.nil? # Si es nil ===> tengo que crearlo
          publishing.title = video_hash[:title]
          publishing.description = video_hash[:description]
          publishing.thumbnail = video_hash[:thumbnail]
          publishing.status = "Published on Youtube"
          publishing.published_at = video_hash[:published_at]
          publishing.user = current_user
          # crear el channel
          unless Channel.where(uid: video_hash[:channel_id]).any?
            channel = Channel.new(uid: video_hash[:channel_id])
            channel.name = video_hash[:channel_name]
            channel.user = current_user
            channel.save
          end
        end
        # Tanto SI existe como si NO existe, quiero actualizar las 8 metricas y guardarlo
        publishing.likes = @data[publishing.uid][:likes]
        publishing.views = @data[publishing.uid][:views]
        publishing.comments = @data[publishing.uid][:comments]
        publishing.shares = @data[publishing.uid][:shares]
        publishing.dislikes = @data[publishing.uid][:dislikes]
        publishing.avg_watch_sec = @data[publishing.uid][:avg_watch_sec]
        publishing.percent_watch = @data[publishing.uid][:percent_watch]
        publishing.impressions = @data[publishing.uid][:impressions]
        publishing.save
      end
      flash[:notice] =  "Videos Up to date!"
      redirect_to overview_path
  end

  def overview
    if current_user.youtube_sessions.last.nil?
        redirect_to youtube_sessions_path
    else
      if params[:query].present?
        @publishings = current_user.publishings.search_by_all_publishing_metrics_and_properties(params[:query])
      else
        @publishings = current_user.publishings
      end
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
