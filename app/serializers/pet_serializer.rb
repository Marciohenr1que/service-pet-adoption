# == Schema Information
#
# Table name: pets
#
#  id         :bigint           not null, primary key
#  breed      :string
#  name       :string
#  pet_type   :string
#  weight     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner_id   :bigint           not null
#
# Indexes
#
#  index_pets_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => owners.id)
#
class PetSerializer < ActiveModel::Serializer
    attributes :id, :name, :breed, :pet_type, :weight
  end
