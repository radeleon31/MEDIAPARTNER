class PublishingsController < ApplicationController
  before_action :set_publishing, only: [:show, :edit, :update, :destroy]

  def index
    @publishings = Publishing.all
  end

  def show
    # Aca seria solo set_publishing
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
  def update_publishings # Boton
    @data = FetchYoutubeAnalytics.call(current_user.youtube_sessions.last) # video_id: view , likes
    @videos = FetchYoutubeVideos.call(current_user.youtube_sessions.last) # Published videos in YT
      @videos.each do |video_hash|
        publishing = Publishing.find_or_initialize_by(uid: video.id.video_id)
        if publishing.id.nil? # Si es nil ===> tengo que crearlo
          publishing.title = video_hash[:title]
          publishing.description = video_hash[:description]
          publishing.thumbnail = video_hash[:thumbnail]
          publishing.channel_id = video_hash[:channel_id]
          publishing.status = "Published on Youtube"
          publishing.user = current_user
          # asignarle un channel
          #publishing.uid = video_hash[:id]
        end
        # Tanto SI existe como si NO existe, quiero actualizar los likes y viwss y guardarlo
        publishing.likes = @data[publishing.uid][:likes]
        publishing.views = @data[publishing.uid][:views]
        publishing.save
      end
      # notice: ""
      redirect_to overview_path
  end
  # 
  # {
  #   title: video.snippet.title,
  #   description: video.snippet.description,
  #   thumbnail: video.snippet.thumbnails.default.url,
  #   id: video.id.video_id,
  #   channel_id: video.snippet.channel_id
  # }

  def overview
    # Este Array es para no agotar quotas a la API
      @videos = [{
        title: "test",
        description: "test",
        thumbnail: "test",
        id: "23",
        channel_id: "23"
      },
      {
        title: "test",
        description: "test",
        thumbnail: "test",
        id: "23",
        channel_id: "23"
      },
      {
        title: "test",
        description: "test",
        thumbnail: "test",
        id: "23",
        channel_id: "23"
      }
      ]
    # if current_user.youtube_sessions.last.nil?
    #     redirect_to youtube_sessions_path
    # else
    # @publishings = current_user.publishings
    # end
  end

  private

  def set_publishing
    @publishing = Publishing.find(params[:id])
  end

  def publishing_params
    params.require(:publishing).permit(:video, :title, :description, :status, :uid )
  end
end
