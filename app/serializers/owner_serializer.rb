# == Schema Information
#
# Table name: owners
#
#  id         :bigint           not null, primary key
#  name       :string
#  email      :string
#  phone      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class OwnerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone
  has_many :pets, serializer: PetSerializer
end
