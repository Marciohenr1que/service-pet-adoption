class Pet < ApplicationRecord
  include Validatable
  include PetValidatable
  belongs_to :owner

  def update_weight(new_weight)
    update(weight: new_weight)
  end
  attr_accessor :breed_info_temp
end
