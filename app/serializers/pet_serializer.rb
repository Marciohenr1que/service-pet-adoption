class PetSerializer < ActiveModel::Serializer
  attributes :name, :pet_type, :breed, :weight, :breed_info_temp_name, :breed_info_temp_description
end
