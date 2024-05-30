# == Schema Information
#
# Table name: breed_infos
#
#  id            :bigint           not null, primary key
#  name          :string
#  description   :text
#  life_span     :string
#  male_weight   :float
#  female_weight :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class BreedInfo< ApplicationRecord
    has_many :pets
end
