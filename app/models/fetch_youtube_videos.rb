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
