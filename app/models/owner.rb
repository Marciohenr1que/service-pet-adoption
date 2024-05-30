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
class Owner < ApplicationRecord
  include Validatable
  include OwnerValidatable
  has_many :pets, dependent: :destroy
end
