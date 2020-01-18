Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
    Rails.application.credentials.google[:client_id],
    Rails.application.credentials.google[:client_secret],
    {
# scope: ログイン後に Youtube Data APIのデータを取得
# また、promptとaccess_typeを以下の設定にするとrefresh_tokenが得られる
      scope: "https://www.googleapis.com/auth/userinfo.email,
              https://www.googleapis.com/auth/userinfo.profile,
              https://www.googleapis.com/auth/youtube.readonly",
      prompt: "select_account",
      access_type: "offline"
    }
  {:provider_ignores_state => true}
end