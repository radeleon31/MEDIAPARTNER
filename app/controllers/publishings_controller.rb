class PublishingsController < ApplicationController
  before_action :set_publishing, only: [:show, :edit, :update, :destroy, :myvideo]
  def index
    @publishings = current_user.publishings
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
    @publishing.channel = current_user.channels.first
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
    @revenue_count = 0
    channels = Channel.where(user: current_user)
    @subscibers_count = 0
    channels.each do |channel|
      @subscibers_count += channel.subscibers
      publishings = channel.publishings
      publishings.each do |publishing|
        if publishing.revenue != nil
        @revenue_count += publishing.revenue
        end
      end
    end
  end

  def insight
  end

  def destroy
    if @publishing.destroy
      redirect_to publishings_path(@publishing)
    else
      render :index
    end
  end

  def update_publishings # Boton
    @data = FetchYoutubeAnalytics.call(current_user.youtube_sessions.last) # video_id: view , likes....
    @videos = FetchYoutubeVideos.call(current_user.youtube_sessions.last) # Published videos in YT

      @videos.each do |video_hash|
        publishing = current_user.publishings.find_or_initialize_by(youtube_video_id: video_hash[:id])
        # publishing = Publishing.find_or_initialize_by(youtube_video_id: video_hash[:id])
        if publishing.new_record? # Si es nil ===> tengo que crearlo
          publishing.title = video_hash[:title]
          publishing.description = video_hash[:description]
          publishing.thumbnail = video_hash[:thumbnail]
          publishing.status = "Published on Youtube"
          publishing.published_at = video_hash[:published_at]
          publishing.user = current_user
          # crear el channel
          # channel = Channel.find_or_initialize_by(youtube_channel_id: video_hash[:channel_id]) # A menos que sea un vide de un channel que ya existe, quiero crearlo
          channel = current_user.channels.find_or_initialize_by(youtube_channel_id: video_hash[:channel_id]) # A menos que sea un vide de un channel que ya existe, quiero crearlo
          if channel.new_record? # Si es nil ===> tengo que crearlo
            channel.name = video_hash[:channel_name]
            channel.subscibers = rand(500...1000)
            channel.user = current_user
            channel.save!
          end
          publishing.channel = channel
        end
        # Tanto SI existe como si NO existe, quiero actualizar las 8 metricas y guardarlo
         if @data.key?(video_hash[:id])  # CHECK POR QUE A VECES NO TRAE LA DATA RECIENTE, de videos recien publicados (evito que se rompa la vista)
          publishing.likes = @data[video_hash[:id]][:likes] + rand(1000...5000)
          publishing.views = @data[video_hash[:id]][:views] + rand(1000...10000)
          publishing.comments = @data[video_hash[:id]][:comments] + rand(1000...5000)
          publishing.shares = @data[video_hash[:id]][:shares] + rand(1000...5000)
          publishing.dislikes = @data[video_hash[:id]][:dislikes]
          publishing.avg_watch_sec = @data[video_hash[:id]][:avg_watch_sec]
          publishing.percent_watch = @data[video_hash[:id]][:percent_watch]
          publishing.impressions = @data[video_hash[:id]][:impressions] + rand(1000...5000)
          publishing.revenue = rand(1000...3000)
         else
          # Fake data
          publishing.likes =  rand(1000...6000)
          publishing.views =  rand(1000...11000)
          publishing.comments =  rand(1000...7000)
          publishing.shares =  rand(1000...5000)
          publishing.dislikes = rand(10...500)
          publishing.avg_watch_sec = rand(10...500)
          publishing.percent_watch = rand(0...100)
          publishing.impressions =  rand(1000...5000)
          publishing.revenue = rand(1000...3000)
         end

        publishing.save! # si la data vino vacia, lo guardo igual para poder tener al menos el video en Overview

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
    params.require(:publishing).permit(:video, :title, :description, :status, :youtube_video_id, :scheduled_at)
  end
end

