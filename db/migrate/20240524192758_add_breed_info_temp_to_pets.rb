class AddBreedInfoTempToPets < ActiveRecord::Migration[7.1]
  def change
    add_column :pets, :breed_info_temp_name, :string
    add_column :pets, :breed_info_temp_description, :text
  end
end
