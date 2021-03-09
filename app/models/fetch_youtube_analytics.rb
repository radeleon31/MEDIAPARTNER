# require 'google/apis/analytics_v3' # ESO ES DE ANALYTICS
require 'google/apis/youtube_v3'
require 'google/apis/youtube_analytics_v2'

class FetchYoutubeAnalytics
  def self.call(session)
    result = Hash.new
    @auth_client ||= Signet::OAuth2::Client.new(session.credentials)
    analytics ||= Google::Apis::YoutubeAnalyticsV2::YouTubeAnalyticsService.new
    analytics.query_report(
      options: { authorization: @auth_client},
      dimensions:"video",
      end_date:Time.now.strftime("%Y-%m-%d"), # Test Only - Cambiar a fecha actual DATE.NOW
      ids:"channel==MINE",
      max_results:10, # Test Only - Cambiar a todos. paginacion?
      metrics:"views,likes,comments,dislikes,shares,averageViewDuration,averageViewPercentage,annotationImpressions",
      sort:"-views",
      start_date:"2019-01-01" # Test Only - Cambiar a variable elegida o predefinida restandole a fecha actual
    ).rows.each do |video_array|
      result[video_array[0]] =
      { 
        views: video_array[1],
        likes: video_array[2],
        comments: video_array[3],
        dislikes: video_array[4],
        shares: video_array[5],
        avg_watch_sec: video_array[6],
        percent_watch: video_array[7],
        impressions: video_array[8]
      }
    end
    result
  end
  # 1) require 'google/apis/youtube_v3'
  # 2) require 'google/apis/youtube_analytics_v2'
  # 3) @auth_client = Signet::OAuth2::Client.new(YoutubeSession.last.credentials)
  # 4) analytics = Google::Apis::YoutubeAnalyticsV2::YouTubeAnalyticsService.new
end