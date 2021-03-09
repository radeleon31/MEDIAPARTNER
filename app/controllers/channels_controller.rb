class ChannelsController < ApplicationController

    def index
      # ojo, debos cambiar esto por el current 
      @user = current_user
      @publishings = Publishing.where(user_id: @user.id).order(created_at: :desc)
      @avg_watch_sec_count = 0
      @percent_watch_count = 0
      @impressions_count = 0
      @comments_count = 0
      @revenue_count = 0
      @publishings.each do |video|
        if (video.avg_watch_sec != nil)
          @avg_watch_sec_count += video.avg_watch_sec
        end
        if (video.percent_watch != nil)
          @percent_watch_count += video.percent_watch
        end
        if (video.impressions != nil)
          @impressions_count += video.impressions
        end
        if (video.comments != nil)
          @comments_count += video.comments
        end
        if (video.revenue != nil)
          @revenue_count += video.revenue
        end
      end
      # @channels = Channel.joins(:Publishing).where(Publishing: {id: params[:client_id]}).merge(Shop.joins(:products).where(products: {id: params[:product_id]}))
      # @channels = Channel.where (user_id: current_user.id).order(created_at: :desc)
      @channels = Channel.where(user: current_user).order(created_at: :desc)
      @name_view = "Perfomance"
    end
    def show

    end

    def last_day
      
      # ojo, debos cambiar esto por el current 
      @user = current_user
      @publishings = Publishing.where(user_id: @user.id).order(created_at: :desc)

      @likes_count = 0
      @dislikes_count = 0
      @views_count = 0
      @shares_count = 0
      @publishings.each do |video|
        if (video.likes != nil)
          @likes_count += video.likes
         end
         if (video.dislikes != nil)
          @dislikes_count += video.dislikes
         end
         if (video.views != nil)
          @views_count += video.views
         end
        if (video.shares != nil)
          @shares_count += video.shares
        end
      end
      @likes_percen = 0
      @dislikes_percen = 0
      @views_percen = 0
      @shares_percen = 0
      if (@publishings.count > 0)
      if (@likes_count != nil)
        @likes_percen = (@likes_count / @publishings.count)
      end
      if (@dislikes_count != nil)
        @dislikes_percen = (@dislikes_count / @publishings.count)
      end
      if (@views_count != nil) 
        @views_percen = (@views_count / @publishings.count)
      end
      if (@shares_count != nil) 
        @shares_percen = (@shares_count / @publishings.count)
      end
    end
     
      
      @name_view = "Insight"
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
