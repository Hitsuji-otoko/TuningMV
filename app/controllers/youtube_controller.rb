class YoutubeController < ApplicationController
  before_action :authenticate_user!, only: :index
  
  GOOGLE_API_KEY = Rails.application.credentials.google[:api_key]

  def find_videos(keyword, after: 1.months.ago, before: Time.now)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY
    next_page_token = nil
    opt = {
      q: keyword,
      type: 'video',
      max_results: 10,
      order: :date,
      page_token: next_page_token,
      published_after: after.iso8601,
      published_before: before.iso8601
    }
    begin
      results = service.list_searches(:snippet, opt)
      results_items = results.to_h
      @search_results = results_items[:items]   # この段階で結果はArrayになる
      
      # 検索結果がない時は、処理を抜ける
      if @search_results.blank?
        return
      end 
    # beginの処理が実行できなかった場合の例外処理
    rescue Google::Apis::YoutubeV3::YouTubeService => err
      puts "YoutubeAPIからの動画取得に問題が発生しました"
      puts err.results.body
    end
    return @search_results
  end

  def matching_feelingbox_videos(playlist_id)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY
    next_page_token = nil
    opt = {
      playlist_id: playlist_id,
      max_results: 10,
      page_token: next_page_token,
    }
    begin
      results = service.list_playlist_items(:snippet, opt)
      results_items = results.to_h
      @search_results = results_items[:items]   # この段階で結果はArrayになる
      
      # 検索結果がない時は、処理を抜ける
      if @search_results.blank?
        return
      end
    # beginの処理が実行できなかった場合の例外処理
    rescue Google::Apis::YoutubeV3::YouTubeService => err
      puts "YoutubeAPIからの動画取得に問題が発生しました"
      puts err.results.body
    end
    return @search_results
  end

  def index
    @youtube_data = find_videos('King Gnu')
    @matching_feelingbox_videos = matching_feelingbox_videos('PLQ6aFfQOcQBO2zPgf9ru4_DDuNFmycpQa')

    # これだとAPIで取得した動画の全件がYoutubesテーブルに保存されてしまう
    @matching_feelingbox_videos.each do |item|
      @mylists = Youtube.new(
        title: item[:snippet][:title],
        author: item[:snippet][:channel_title],
        context: item[:snippet][:description]
      )
      @mylists.save
    end
  end

  def create
    # APIで取得した動画のうち、特定のものだけをYoutubesテーブルに保存したい
  end

end