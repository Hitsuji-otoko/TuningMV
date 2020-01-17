FactoryBot.define do
  factory :youtube do
    specific_id { "SPECIFICID" }
    video_id { "VIDEOID" }
    playlist_id { "PLAYLISTID" }
    title { "test" }
    description { "test" }
  end
end