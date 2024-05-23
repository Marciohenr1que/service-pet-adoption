class PetSerializer < ActiveModel::Serializer
    attributes :name, :pet_type, :breed, :weight
  end