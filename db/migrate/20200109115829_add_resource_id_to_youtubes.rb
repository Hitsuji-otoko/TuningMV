class AddResourceIdToYoutubes < ActiveRecord::Migration[5.2]
  def change
    add_column :youtubes, :resource_id, :text
    add_column :youtubes, :channel_title, :text
  end
end
