require 'google/apis/youtube_v3'
require 'google/apis/analytics_v3'

class FetchYoutubeVideos
  # def initialize(session)
  #   @session = session
  # end
  def self.call(session)
    service ||= Google::Apis::YoutubeV3::YouTubeService.new
    @auth_client ||= Signet::OAuth2::Client.new(session.credentials)
    service.list_searches(
      'snippet',
      for_mine: true,
      type: 'video',
      options: { authorization: @auth_client}
    ).items.map do |video|
       {
         title: video.snippet.title,
         description: video.snippet.description,
         thumbnail: video.snippet.thumbnails.default.url,
         id: video.id.video_id,
         channel_id: video.snippet.channel_id
       }
    end
  end
end

class FetchYoutubeAnalytics
  
  def self.call(session)
    @auth_client ||= Signet::OAuth2::Client.new(session.credentials)
    analytics ||= Google::Apis::AnalyticsV3::AnalyticsService.new   
    analytics.get_realtime_data(
      "ga:56789", # Table ID
      "rt:activeUsers", # Metrics
      options: { authorization: @auth_client}
      )
      # ERROR:
      # Google::Apis::ClientError: insufficientPermissions: Request had insufficient authentication scopes.
      # YA SE AMPLIARON LOS SCOPES Y ME PIDIERON LOS PERMISOS
    end
end