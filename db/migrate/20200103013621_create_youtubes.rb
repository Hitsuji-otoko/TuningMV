class CreateYoutubes < ActiveRecord::Migration[5.2]
  def change
    create_table :youtubes do |t|
      t.string :title
      t.string :context

      t.timestamps
    end
  end
end
