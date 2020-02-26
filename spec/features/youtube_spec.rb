require 'rails_helper'

RSpec.feature "Youtubes#Feature_test", type: :feature do
  background do
    @user = FactoryBot.create(:user)
  end

  context 'まだユーザー登録をしていない場合' do
    scenario 'ユーザー登録をしてMVページにリダイレクトする' do 
      visit root_path
      click_button "MVページ"
      visit new_user_session_path
      click_link "ユーザー登録"
      visit new_user_registration_path
      fill_in "ユーザー名", with: @user.username
      fill_in "メールアドレス", with: @user.email
      within '.form-group.password.required.user_password' do
        fill_in "パスワード", with: @user.password
      end
      fill_in "確認用パスワード", with: @user.password_confirmation
      visit youtube_index_path

      expect(page).to have_http_status "200"
    end
  end

  context 'ユーザー登録済みでログインしたい場合' do
    scenario 'ログインしてMVページにリダイレクトする' do
      visit root_path
      click_button "MVページ"
      visit new_user_session_path
      fill_in "ユーザー名", with: @user.username
      fill_in "パスワード", with: @user.password
      # チェックボックスはチェックしてもしなくても良い
      click_button "Log in"
      visit youtube_index_path

      expect(page).to have_http_status "200"
    end
  end
end
