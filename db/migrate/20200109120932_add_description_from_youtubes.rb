class AddDescriptionFromYoutubes < ActiveRecord::Migration[5.2]
  def change
    add_column :youtubes, :description, :text
  end
end
