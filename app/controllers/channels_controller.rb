class ChannelsController < ApplicationController

    def index
      # ojo, debos cambiar esto por el current 
      @user = User.last 
      @publishings = Publishing.where(user_id: @user.id)
      @avg_watch_sec_count = 0
      @percent_watch_count = 0
      @impressions_count = 0
      @comments_count = 0
      @publishings.each do |video|
        @avg_watch_sec_count += video.avg_watch_sec
        @percent_watch_count += video.percent_watch
        @impressions_count += video.impressions
        @comments_count += video.comments
      end
      @channels = Channel.all.order(created_at: :desc)
    end
    def show

    end

    def last_day
      
      # ojo, debos cambiar esto por el current 
      @user = User.last 
      @publishings = Publishing.where(user_id: @user.id).order(created_at: :desc)

      @likes_count = 0
      @dislikes_count = 0
      @views_count = 0
      @shares_count = 0
      @publishings.each do |video|
        @likes_count += video.likes
        @dislikes_count += video.dislikes
        @views_count += video.views
        @shares_count += video.shares
      end
      @likes_percen = 0
      @dislikes_percen = 0
      @views_percen = 0
      @shares_percen = 0
      @likes_percen = (@likes_count / @publishings.count)
      @dislikes_percen = (@dislikes_count / @publishings.count) 
      @views_percen = (@views_count / @publishings.count) 
      @shares_percen = (@shares_count / @publishings.count) 
      
      @name_view = "Video Statistics"
    end

    def last_week
        @data = {fill_rate_value: 16, fill_rate_porcen: 12.00, 
        Impressions_value: "362,000", Impressions_porcen: 14.51,
        eCPM_value: 1.98, eCPM_porcen: 47.34,
        est_rev_value: 967, est_rev_porcen: 8.08,
        }
        @name_view = "Last Week"
    end

    def last_month
        @data = {fill_rate_value: 29, fill_rate_porcen: 12.73, 
        Impressions_value: "95,000", Impressions_porcen: 7.98,
        eCPM_value: 3.05, eCPM_porcen: 31.75,
        est_rev_value: 498, est_rev_porcen: 9.56,
        }
        @name_view = "Last Month"
    end

    def last_year
        @data = {fill_rate_value: 23, fill_rate_porcen: 23.88, 
        Impressions_value: "215,000", Impressions_porcen: 27.48,
        eCPM_value: 1.55, eCPM_porcen: 29.99,
        est_rev_value: 330, est_rev_porcen: 6.17,
        }
        @data_channel = {
  "channel1" => {name: "Mi Channel Uff", views: 2388},
  }
  @name_view = "Last Year"
    end
end
