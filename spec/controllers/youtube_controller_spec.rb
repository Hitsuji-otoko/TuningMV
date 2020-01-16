require 'rails_helper'

RSpec.describe YoutubeController, type: :controller do
  describe "#index" do
    context '認可済みのユーザーの場合' do
      before do
        @user = FactoryBot.create(:user)
      end

      it '正常にレスポンスを返すこと' do
        sign_in @user
        get :index
        expect(response).to be_successful
      end

      it '200レスポンスを返すこと' do
        sign_in @user
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context '未認可のユーザーの場合' do
      it '302レスポンスを返すこと' do
        get :index
        expect(response).to have_http_status "302"
      end

      it 'ログイン画面にリダイレクトすること' do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#show" do
    context '認可済みのユーザーの場合' do
      before do
        @user = FactoryBot.create(:user)
        @youtube = FactoryBot.create(:youtube, user_id: @user.id)
      end

      it '正常にレスポンスを返すこと' do
        sign_in @user
        get :show, params: { id: @youtube.id }
        expect(response).to be_successful
      end

      it '200レスポンスを返すこと' do
        sign_in @user
        get :show, params: { id: @youtube.id }
        expect(response).to have_http_status "200"
      end
    end

    context '未認可のユーザーの場合' do
      before do
        @youtube = FactoryBot.create(:youtube)
      end
      it 'ログイン画面にリダイレクトすること' do
        get :show, params: { id: @youtube.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  # TODO
  # エラー：URIにAPIから取得したパラメータを入れる必要があるため
  # describe "#create" do
  #   context '認可済みのユーザーの場合' do
  #     before do
  #       @user = FactoryBot.create(:user)
  #     end

  #     it 'プレイリスト(youtubeテーブル)を追加できること' do
  #       youtube_params = FactoryBot.attributes_for(:youtube)
  #       sign_in @user
  #       expect { post :youtube, 
  #         params: { youtube: youtube_params } 
  #       }.to change(@user.youtubes, :count).by(1)
  #     end
  #   end
  # end

  describe "#destroy" do
    context '認可済みのユーザーの場合' do
      before do
        @user = FactoryBot.create(:user)
        @youtube = FactoryBot.create(:youtube, user_id: @user.id)
      end

      it 'プレイリストから動画を削除できること' do
        sign_in @user
        expect { delete :destroy,
          params: {id: @youtube.id } 
        }.to change(@user.youtubes, :count).by(-1) 
      end
    end

    context '未認可のユーザーの場合' do
      before do
        @youtube = FactoryBot.create(:youtube)
      end

      it '302レスポンスを返すこと' do
        delete :destroy, params: { id: @youtube.id }
        expect(response).to have_http_status "302"
      end

      it 'ログイン画面にリダイレクトすること' do
        delete :destroy, params: { id: @youtube.id }
        expect(response).to redirect_to "/users/sign_in"
      end

      it 'プレイリストから動画を削除できないこと' do
        expect { delete :destroy, 
          params: { id: @youtube.id }
        }.to_not change(Youtube, :count)    # TODO: think
      end
    end
  end
end
