# require 'google/apis/analytics_v3' # ESO ES DE ANALYTICS
require 'google/apis/youtube_v3'
require 'google/apis/youtube_analytics_v2'

class FetchYoutubeAnalytics
  def self.call(session)
    @auth_client ||= Signet::OAuth2::Client.new(session.credentials)
    analytics ||= Google::Apis::YoutubeAnalyticsV2::YouTubeAnalyticsService.new
    analytics.query_report(
      "ga:56789", # Table ID
      "rt:activeUsers", # Metrics
      options: { authorization: @auth_client}
      )
      analytics.query_report(
        options: { authorization: @auth_client},
        dimensions:"video",
        end_date:"2021-03-03", # Test Only - Cambiar a fecha actual
        ids:"channel==MINE",
        max_results:10, # Test Only - Cambiar a todos. paginacion?
        metrics:"views,likes",
        sort:"-views",
        start_date:"2019-01-01" # Test Only - Cambiar a variable elegida o predefinida restandole a fecha actual
      )
    end
  end
  # 1) require 'google/apis/youtube_v3'
  # 2) require 'google/apis/youtube_analytics_v2'
  # 3) @auth_client = Signet::OAuth2::Client.new(YoutubeSession.last.credentials)
  # 4) analytics = Google::Apis::YoutubeAnalyticsV2::YouTubeAnalyticsService.new
  # 5) analytics.query_report(options: { authorization: @auth_client},dimensions:"video",end_date:"2021-03-03",ids:"channel==MINE",max_results:10,metrics:"views,likes",sort:"-views",start_date:"2019-01-01")
end
  