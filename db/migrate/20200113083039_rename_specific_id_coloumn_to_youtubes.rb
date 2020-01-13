class RenameSpecificIdColoumnToYoutubes < ActiveRecord::Migration[5.2]
  def change
    rename_column :youtubes, :video_id, :specific_id
  end
end
