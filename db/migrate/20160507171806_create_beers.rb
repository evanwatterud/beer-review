class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :brewer, null: false
      t.string :style, null: false
      t.string :brewing_country, null: false
      t.float :abv, null: false

      t.timestamps null: false
    end
    add_index :beers, :name, unique: true
  end
end
