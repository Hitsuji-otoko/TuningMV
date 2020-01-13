class AddSnippetToYoutubes < ActiveRecord::Migration[5.2]
  def change
    add_column :youtubes, :snippet, :text
  end
end
