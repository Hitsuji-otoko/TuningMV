class YoutubeController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :match_playlist, :user_playlist]
  
  GOOGLE_API_KEY = Rails.application.credentials.google[:api_key]

  def index
    # @find_videos = find_videos('King Gnu')
    @playlist_videos = playlist_videos("PLQ6aFfQOcQBO2zPgf9ru4_DDuNFmycpQa")
  end

  def new
    @playlist_video = Youtube.new
  end

  def create
    # APIで取得した動画のうち、view側で指定したものだけを保存する
    @playlist_video = Youtube.create(
      specific_id: params[:specific_id],
      video_id: params[:video_id],
      playlist_id: params[:playlist_id],
      title: params[:title],
      description: params[:description],
      user_id: current_user.id
    )
    if @playlist_video.save
      redirect_to @playlist_video, notice: "「#{@playlist_video.title}」をリストに追加しました"
    end
  end

  def show
    @playlist_video = Youtube.find(params[:id])
  end

  def destroy
    playlist_video = Youtube.find(params[:id])
    if playlist_video.destroy
      redirect_to youtube_user_playlist_path, alert: "「#{playlist_video.title}」をリストから削除しました"
    end
  end

  def match_playlist
    # paramsが空だとAPIメソッドがエラーとなってしまうので回避
    params[:playlist_id].blank? ? @playlist_videos = playlist_videos('PLQ6aFfQOcQBO2zPgf9ru4_DDuNFmycpQa') : @playlist_videos = playlist_videos(params[:playlist_id])
  end

  def user_playlist
    @playlist_videos = Youtube.page(params[:page])
  end

  private

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
      search_results = results_items[:items]   # この段階で結果はArrayになる
      
      # 検索結果がない時は、処理を抜ける
      if search_results.blank?
        return
      end 
    # beginの処理が実行できなかった場合の例外処理
    rescue Google::Apis::YoutubeV3::YouTubeService => err
      puts "YoutubeAPIからの動画取得に問題が発生しました"
      puts err.results.body
    end
    return search_results
  end

  def playlist_videos(playlist_id)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY
    next_page_token = nil
    opt = {
      playlist_id: playlist_id,
      max_results: 50,
      page_token: next_page_token,
    }
    begin
      results = service.list_playlist_items(:snippet, opt)
      results_items = results.to_h
      search_results = results_items[:items]   # この段階で結果はArrayになる
      # 検索結果がない時は、処理を抜ける
      if search_results.blank?
        return
      end
    # beginの処理が実行できなかった場合の例外処理
    rescue Google::Apis::YoutubeV3::YouTubeService => err
      puts "YoutubeAPIからの動画取得に問題が発生しました"
      puts err.results.body
    end
    return search_results
  end

end