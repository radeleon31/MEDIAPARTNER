class ChannelsController < ApplicationController

    def index
    end
    def show

    end

    def last_day
      
      # ojo, debos cambiar esto por el current 
       @user = User.last 
       @publishings = Publishing.where(user_id: @user.id)
       
       @publishings.each do |video|
         video.likes + video.likes
         @likes_count = video.likes
         @likes_percen = video.likes / @publishings.count
         video.dislikes + video.dislikes
         @dislikes_count = video.dislikes
         @dislikes_percen = video.dislikes  / @publishings.count
         video.views + video.views
         @views_count = video.views
         @views_percen = video.views / @publishings.count
         video.shares + video.shares
         @shares_count = video.shares
         @shares_percen = video.shares  / @publishings.count
       end
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
