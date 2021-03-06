# require 'google/apis/youtube_v3'
require 'google/api_client/client_secrets'


class YoutubeSessionsController < ApplicationController
  def new
    redirect_to auth_client.authorization_uri.to_s
    # add a buttom to tell the user to log in/ will be a link to authorization
  end

  def callback
    auth_client.code = params[:code]
    auth_client.fetch_access_token!
    auth_client.client_secret = nil

    # Store the auth client creds in the db
    session[:credentials] = auth_client.to_json
    YoutubeSession.create!(credentials: JSON.parse(auth_client.to_json), user:current_user)
    redirect_to '/'
  end

  def auth_client
    @_auth_client ||= begin
      client_secrets = Google::APIClient::ClientSecrets.new(
        {
          "web":{
            "client_id": Rails.application.credentials.dig(:youtube, :client_id),
            "project_id": "youtube-data-api-test-306316",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_secret": Rails.application.credentials.dig(:youtube, :client_secret),
            "redirect_uris": [
              redirect_uri
            ]
          }
        }
      )
      auth_client = client_secrets.to_authorization
      auth_client.update!(
        scope: ['https://www.googleapis.com/auth/youtube.force-ssl','https://www.googleapis.com/auth/yt-analytics.readonly','https://www.googleapis.com/auth/yt-analytics-monetary.readonly','https://www.googleapis.com/auth/youtubepartner','https://www.googleapis.com/auth/youtube.readonly','https://www.googleapis.com/auth/youtube','https://www.googleapis.com/auth/analytics'],
        redirect_uri: redirect_uri,
        additional_parameters: {
          access_type:'offline',
          include_granted_scopes: true,
        }
      )
      auth_client
    end
  end

  def redirect_uri
    # 'http://localhost:3000/youtube_sessions/callback'
    "#{request.base_url}/youtube_sessions/callback"
  end
end
