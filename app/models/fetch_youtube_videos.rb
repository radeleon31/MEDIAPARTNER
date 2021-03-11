require 'google/apis/youtube_v3'

class FetchYoutubeVideos
  # def initialize(session)
  #   @session = session
  # end
  def self.call(session)
    service ||= Google::Apis::YoutubeV3::YouTubeService.new
    @auth_client ||= Signet::OAuth2::Client.new(session.credentials)
    service.list_searches(
      'snippet',
      max_results:50,
      for_mine: true,
      type: 'video',
      options: { authorization: @auth_client}
    ).items.map do |video|
       {
         title: video.snippet.title,
         description: video.snippet.description,
         thumbnail: video.snippet.thumbnails.default.url,
         id: video.id.video_id,
         channel_id: video.snippet.channel_id,
         channel_name:video.snippet.channel_title,
         published_at:video.snippet.published_at
       }
    end
  end
end
