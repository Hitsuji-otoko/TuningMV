class RemoveContextFromYoutubes < ActiveRecord::Migration[5.2]
  def change
    remove_column :youtubes, :context, :string
  end
end
