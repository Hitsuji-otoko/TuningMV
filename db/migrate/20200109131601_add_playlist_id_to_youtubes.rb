class AddPlaylistIdToYoutubes < ActiveRecord::Migration[5.2]
  def change
    add_column :youtubes, :playlist_id, :text
  end
end
