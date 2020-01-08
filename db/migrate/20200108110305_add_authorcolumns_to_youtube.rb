class AddAuthorcolumnsToYoutube < ActiveRecord::Migration[5.2]
  def change
    add_column :youtubes, :author, :string
  end
end
