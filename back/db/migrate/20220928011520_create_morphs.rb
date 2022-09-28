class CreateMorphs < ActiveRecord::Migration[6.1]
  def change
    create_table :morphs do |t|
      t.string :name,   null: false, uniqueness: true
      t.string :symbol, null: false, uniqueness: true

      t.timestamps
    end
  end
end
