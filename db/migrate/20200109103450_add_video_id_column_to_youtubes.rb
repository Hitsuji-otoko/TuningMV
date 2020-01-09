class AddVideoIdColumnToYoutubes < ActiveRecord::Migration[5.2]
  def change
    add_column :youtubes, :video_id, :string
  end
end
