class CreateMoments < ActiveRecord::Migration[7.0]
  def change
    create_table :moments do |t|
      t.string :title
      t.text :description, null: false
      t.date :event_date, null: false

      t.timestamps
    end
  end
end
