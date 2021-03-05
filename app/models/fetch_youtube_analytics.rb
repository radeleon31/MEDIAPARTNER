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
      end_date:"2021-03-03", # Test Only - Cambiar a fecha actual
      ids:"channel==MINE",
      max_results:10, # Test Only - Cambiar a todos. paginacion?
      metrics:"views,likes",
      sort:"-views",
      start_date:"2019-01-01" # Test Only - Cambiar a variable elegida o predefinida restandole a fecha actual
    ).rows.each do |video_array|
        result[video_array[0]] = { views: video_array[1], likes: video_array[2] }
    end
    result
  end
  # 1) require 'google/apis/youtube_v3'
  # 2) require 'google/apis/youtube_analytics_v2'
  # 3) @auth_client = Signet::OAuth2::Client.new(YoutubeSession.last.credentials)
  # 4) analytics = Google::Apis::YoutubeAnalyticsV2::YouTubeAnalyticsService.new
  # Queries:
  # 1) TEST: analytics.query_report(options: { authorization: @auth_client}, 
        # dimensions:"video",
        # end_date:"2021-03-03",
        # ids:"channel==MINE",
        # max_results:10,
        # metrics:"views,likes",
        # sort:"-views",
        # start_date:"2019-01-01")
  # 2) analytics.query_report(options: { authorization: @auth_client}, 
  #       dimensions:"video",
  #       end_date:"2021-03-03",
  #       ids:"channel==MINE",
  #       max_results:10,
  #       metrics:"views,comments,likes,dislikes,shares",
  #       sort:"-views",
  #       start_date:"2019-01-01")
  # 2) analytics.query_report(options: { authorization: @auth_client}, 
  #       dimensions:"video",
  #       end_date:"2021-03-03",
  #       ids:"channel==MINE",
  #       max_results:10,
  #       metrics:"views,comments,likes,dislikes,shares",
  #       sort:"-views",
  #       start_date:"2019-01-01")
  # 3) analytics.query_report(options: { authorization: @auth_client}, 
  #       dimensions:"video",
  #       end_date:"2021-03-03",
  #       ids:"channel==MINE",
  #       max_results:10,
  #       metrics:"estimatedMinutesWatched,views",
  #       sort:"-views",
  #       start_date:"2019-01-01")
  # 4) analytics.query_report(options: { authorization: @auth_client}, 
  #       dimensions:"video",
  #       end_date:"2021-03-03",
  #       ids:"channel==MINE",
  #       max_results:10,
  #       metrics:"averageViewPercentage,views",
  #       sort:"-views",
  #       start_date:"2019-01-01")
  # 5)  forbidden:.query_report(options: { authorization: @auth_client}, 
  #       dimensions:"channel",
  #       end_date:"2021-03-03",
  #       ids:"channel==MINE",
  #       max_results:10,
  #       metrics:"estimatedAdRevenue",
  #       sort:"-estimatedAdRevenue",
  #       start_date:"2019-01-01")
        
end