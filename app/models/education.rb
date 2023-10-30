class Education < ApplicationRecord
  belongs_to :cv, dependent: :destroy
end
