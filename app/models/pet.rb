class Pet < ApplicationRecord
  include Validatable
  include PetValidatable
  belongs_to :owner
  belongs_to :breed_info, optional: true
end
