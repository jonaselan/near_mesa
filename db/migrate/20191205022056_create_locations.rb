class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.float :latitude
      t.float :longitude
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
