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
    end
  end
  # dimensions:"video",endDate:"2021-01-01",ids:"channel==MINE",maxResults:10,metrics:"views,likes",sort:"-views",startDate:"2010-01-01"
  # 1) require 'google/apis/youtube_v3'
  # 2) require 'google/apis/youtube_analytics_v2'
  # 3) @auth_client = Signet::OAuth2::Client.new(YoutubeSession.last.credentials)
  # 4) analytics = Google::Apis::YoutubeAnalyticsV2::YouTubeAnalyticsService.new
  # 5) analytics.query_report(options: { authorization: @auth_client},dimensions:"video",end_date:"2021-03-03",ids:"channel==MINE",max_results:10,metrics:"views,likes",sort:"-views",start_date:"2020-01-01")
  





  # analytics.query_report(options: { authorization: @auth_client},
  # ids: 'channel==MINE',
  #metrics:'views',end_date:'2021-02-01',
  # start_date:'2020-02-01')


  # ERROR:
  # Google::Apis::ClientError: insufficientPermissions: Request had insufficient authentication scopes.
  # YA SE AMPLIARON LOS SCOPES Y ME PIDIERON LOS PERMISOS

  #ERROR
  # Google::Apis::ClientError: accessNotConfigured: Google Analytics API has not been used in project 957706471560 
  # before or it is disabled. Enable it by visiting 
  # https://console.developers.google.com/apis/api/analytics.googleapis.com/overview?project=957706471560 then retry. If you enabled this API recently, wait a few minutes for the action to propagate to our systems and retry.
  # Google::Apis::ClientError: insufficientPermissions: User does not have any Google Analytics account
  