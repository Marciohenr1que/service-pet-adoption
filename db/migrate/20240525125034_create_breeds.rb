class CreateBreeds < ActiveRecord::Migration[7.1]
  def change
    create_table :breed_infos do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
