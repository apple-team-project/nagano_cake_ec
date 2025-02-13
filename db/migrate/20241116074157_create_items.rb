class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :genre, null: false, foreign_key: true
      t.string :name,null: false
      t.string :description,null: false
      t.integer :price,null: false
      t.boolean :is_active,null: false,default: true
      t.timestamps
    end
  end
end
