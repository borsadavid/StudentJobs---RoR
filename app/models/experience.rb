class Experience < ApplicationRecord
  belongs_to :cv, dependent: :destroy
end
