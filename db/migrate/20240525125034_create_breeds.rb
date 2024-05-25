class CreateBreeds < ActiveRecord::Migration[7.1]
  def change
    create_table :breeds do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
