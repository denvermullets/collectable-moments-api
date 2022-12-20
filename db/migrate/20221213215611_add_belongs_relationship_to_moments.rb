class AddBelongsRelationshipToMoments < ActiveRecord::Migration[7.0]
  def change
    add_reference :moments, :user, foreign_key: true, null: :false
  end
end
