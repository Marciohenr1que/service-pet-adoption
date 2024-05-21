class PetSerializer < ActiveModel::Serializer
  attributes :id, :name, :pet_type, :breed, :weight, :owner_id, :created_at, :updated_at, :description, :life_span, :male_weight, :female_weight

  def description
    object.breed_info[:description]
  end

  def life_span
    object.breed_info[:life_span]
  end

  def male_weight
    object.breed_info[:male_weight]
  end

  def female_weight
    object.breed_info[:female_weight]
  end
end