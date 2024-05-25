class PetSerializer < ActiveModel::Serializer
    attributes :id, :name, :breed, :pet_type, :weight
  end